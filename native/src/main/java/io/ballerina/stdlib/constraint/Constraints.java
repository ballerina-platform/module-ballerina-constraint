/*
 * Copyright (c) 2022, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
 *
 * WSO2 Inc. licenses this file to you under the Apache License,
 * Version 2.0 (the "License"); you may not use this file except
 * in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

package io.ballerina.stdlib.constraint;

import io.ballerina.runtime.api.types.AnnotatableType;
import io.ballerina.runtime.api.types.ArrayType;
import io.ballerina.runtime.api.types.FiniteType;
import io.ballerina.runtime.api.types.IntersectionType;
import io.ballerina.runtime.api.types.RecordType;
import io.ballerina.runtime.api.types.Type;
import io.ballerina.runtime.api.types.TypeTags;
import io.ballerina.runtime.api.types.UnionType;
import io.ballerina.runtime.api.utils.TypeUtils;
import io.ballerina.runtime.api.utils.ValueUtils;
import io.ballerina.runtime.api.values.BArray;
import io.ballerina.runtime.api.values.BError;
import io.ballerina.runtime.api.values.BMap;
import io.ballerina.runtime.api.values.BTypedesc;
import io.ballerina.stdlib.constraint.annotations.AbstractAnnotations;
import io.ballerina.stdlib.constraint.annotations.RecordFieldAnnotations;
import io.ballerina.stdlib.constraint.annotations.TypeAnnotations;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Optional;

import static io.ballerina.stdlib.constraint.Constants.SYMBOL_CLOSE_SQUARE_BRACKET;
import static io.ballerina.stdlib.constraint.Constants.SYMBOL_DOLLAR_SIGN;
import static io.ballerina.stdlib.constraint.Constants.SYMBOL_OPEN_SQUARE_BRACKET;

/**
 * Extern functions for validating constraints.
 */
public class Constraints {

    public static Object validate(Object value, BTypedesc typedesc) {
        Type type = typedesc.getDescribingType();

        try {
            value = cloneWithTargetType(value, type);
        } catch (BError e) {
            return ErrorUtils.buildTypeConversionError(e);
        }

        try {
            List<ConstraintErrorInfo> failedConstraintsInfo = validateAfterTypeConversionInternal(value, type,
                    SYMBOL_DOLLAR_SIGN, false);
            if (!failedConstraintsInfo.isEmpty()) {
                return ErrorUtils.buildValidationError(failedConstraintsInfo);
            }
            return value;
        } catch (InternalValidationException e) {
            return ErrorUtils.createGenericError(e.getMessage());
        } catch (RuntimeException e) {
            return ErrorUtils.buildUnexpectedError(e);
        }
    }

    public static Object validateAfterTypeConversion(Object value, Type type) {
        try {
            List<ConstraintErrorInfo> failedConstraints = validateAfterTypeConversionInternal(value, type,
                    SYMBOL_DOLLAR_SIGN, false);
            if (!failedConstraints.isEmpty()) {
                return ErrorUtils.buildValidationError(failedConstraints);
            }
            return value;
        } catch (InternalValidationException e) {
            return ErrorUtils.createGenericError(e.getMessage());
        } catch (RuntimeException e) {
            return ErrorUtils.buildUnexpectedError(e);
        }
    }

    private static List<ConstraintErrorInfo> validateArrayMembers(Object value, ArrayType type, String path) {
        Type memberType = type.getElementType();
        BArray members = ((BArray) value);
        List<ConstraintErrorInfo> failedConstraints = new ArrayList<>();
        for (int i = 0; i < members.getLength(); i++) {
            failedConstraints.addAll(validateAfterTypeConversionInternal(members.get(i), memberType, path +
                                        SYMBOL_OPEN_SQUARE_BRACKET + i + SYMBOL_CLOSE_SQUARE_BRACKET, true));
        }
        return failedConstraints;
    }

    private static List<ConstraintErrorInfo> validateAfterTypeConversionInternal(Object value, Type type, String path,
                                                                                 boolean isMemberValue) {
        if (type.isReadOnly()) {
            type = getTypeFromReadOnly(type);
        }
        if (type instanceof ArrayType) {
            return validateArrayMembers(value, (ArrayType) type, path);
        }
        List<ConstraintErrorInfo> failedConstraintsInfo = new ArrayList<>();
        if (type instanceof AnnotatableType) {
            AbstractAnnotations annotations = getAnnotationImpl(type, failedConstraintsInfo);
            annotations.validate(value, (AnnotatableType) type, path, isMemberValue);
            // A named union is a type reference, possibly to a readonly intersection; the annotation validation
            // does not reach its members.
            Type impliedType = TypeUtils.getImpliedType(type);
            if (impliedType instanceof UnionType) {
                failedConstraintsInfo.addAll(validateUnionMember(value, impliedType, path, isMemberValue));
            }
        } else if (type instanceof UnionType) {
            return validateUnionMember(value, type, path, isMemberValue);
        }
        return failedConstraintsInfo;
    }

    private static List<ConstraintErrorInfo> validateUnionMember(Object value, Type unionType, String path,
                                                                 boolean isMemberValue) {
        Optional<Type> matchingType = getMatchingType(value, unionType);
        if (matchingType.isPresent()) {
            return validateAfterTypeConversionInternal(value, matchingType.get(), path, isMemberValue);
        }
        return Collections.emptyList();
    }

    private static Type getTypeFromReadOnly(Type type) {
        IntersectionType intersectionType = null;
        if (type instanceof RecordType) {
            Optional<IntersectionType> optionalIntersectionType = ((RecordType) type).getIntersectionType();
            if (optionalIntersectionType.isPresent()) {
                intersectionType = optionalIntersectionType.get();
            }
        } else if (type instanceof IntersectionType) {
            intersectionType = (IntersectionType) type;
        }
        if (intersectionType != null) {
            List<Type> constituentTypes = intersectionType.getConstituentTypes();
            if (constituentTypes.size() == 2) {
                if (constituentTypes.get(0).getTag() == TypeTags.READONLY_TAG) {
                    type = TypeUtils.getReferredType(constituentTypes.get(1));
                } else {
                    type = TypeUtils.getReferredType(constituentTypes.get(0));
                }
            }
        }
        return type;
    }

    private static Optional<Type> getMatchingType(Object value, Type type) {
        Type valueType;
        if (value instanceof BMap) {
            valueType = ((BMap<?, ?>) value).getTypedesc().getDescribingType();
            // The describing type of an immutable value is a singleton type of that value.
            if (TypeUtils.getImpliedType(valueType) instanceof FiniteType) {
                valueType = TypeUtils.getType(value);
            }
        } else {
            // TODO: This flow is not working as expected due to
            //  https://github.com/ballerina-platform/ballerina-lang/issues/37050
            valueType = TypeUtils.getType(value);
        }
        for (Type typ : ((UnionType) type).getMemberTypes()) {
            if (isMatchingMember(valueType, typ)) {
                return Optional.of(typ);
            }
        }
        return Optional.empty();
    }

    private static boolean isMatchingMember(Type valueType, Type memberType) {
        Type value = TypeUtils.getImpliedType(valueType);
        Type member = TypeUtils.getImpliedType(memberType);
        if (value.equals(member)) {
            return true;
        }
        if (value instanceof ArrayType && member instanceof ArrayType) {
            return isMatchingMember(((ArrayType) value).getElementType(), ((ArrayType) member).getElementType());
        }
        // An immutable record is a distinct type that records the mutable record in its intersection.
        if (value instanceof RecordType) {
            Optional<IntersectionType> intersectionType = ((RecordType) value).getIntersectionType();
            return intersectionType.isPresent() && intersectionType.get().getConstituentTypes().stream()
                    .anyMatch(constituent -> TypeUtils.getImpliedType(constituent).equals(member));
        }
        return false;
    }

    private static AbstractAnnotations getAnnotationImpl(Type type, List<ConstraintErrorInfo> failedConstraints) {
        if (type instanceof RecordType) {
            return new RecordFieldAnnotations(failedConstraints);
        } else {
            return new TypeAnnotations(failedConstraints);
        }
    }

    private static Object cloneWithTargetType(Object value, Type targetType) {
        return TypeUtils.isSameType(TypeUtils.getType(value), targetType) ? value
                : ValueUtils.convert(value, targetType);
    }

    private Constraints() {
    }
}
