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

import io.ballerina.runtime.api.creators.ValueCreator;
import io.ballerina.runtime.api.types.AnnotatableType;
import io.ballerina.runtime.api.types.RecordType;
import io.ballerina.runtime.api.types.Type;
import io.ballerina.runtime.api.types.UnionType;
import io.ballerina.runtime.api.utils.TypeUtils;
import io.ballerina.runtime.api.values.BMap;
import io.ballerina.runtime.api.values.BTypedesc;
import io.ballerina.stdlib.constraint.annotations.AbstractAnnotations;
import io.ballerina.stdlib.constraint.annotations.RecordFieldAnnotations;
import io.ballerina.stdlib.constraint.annotations.TypeAnnotations;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import static io.ballerina.stdlib.constraint.Constants.SYMBOL_DOLLAR_SIGN;

/**
 * Extern functions for validating constraints.
 */
public class Constraints {

    public static Object validate(Object value, BTypedesc typedesc) {
        List<String> failedConstraints = new ArrayList<>();
        try {
            Type type = typedesc.getDescribingType();
            if (type instanceof AnnotatableType) {
                AbstractAnnotations annotations = getAnnotationImpl(type, failedConstraints);
                annotations.validate(value, (AnnotatableType) type, SYMBOL_DOLLAR_SIGN);
            } else if (type instanceof UnionType) {
                Optional<Type> matchingType = getMatchingType(value, type);
                if (matchingType.isPresent()) {
                    return validate(value, ValueCreator.createTypedescValue(matchingType.get()));
                }
            }
            if (!failedConstraints.isEmpty()) {
                return ErrorUtils.buildValidationError(failedConstraints);
            }
            return value;
        } catch (InternalValidationException e) {
            return ErrorUtils.createError(e.getMessage());
        } catch (RuntimeException e) {
            return ErrorUtils.buildUnexpectedError();
        }
    }

    private static Optional<Type> getMatchingType(Object value, Type type) {
        Type valueType;
        if (value instanceof BMap) {
            valueType = ((BMap<?, ?>) value).getTypedesc().getDescribingType();
        } else {
            // TODO: This flow is not working as expected due to
            //  https://github.com/ballerina-platform/ballerina-lang/issues/37050
            valueType = TypeUtils.getType(value);
        }
        for (Type typ : ((UnionType) type).getMemberTypes()) {
            if (TypeUtils.getReferredType(typ).equals(valueType)) {
                return Optional.of(typ);
            }
        }
        return Optional.empty();
    }

    private static AbstractAnnotations getAnnotationImpl(Type type, List<String> failedConstraints) {
        if (type instanceof RecordType) {
            return new RecordFieldAnnotations(failedConstraints);
        } else {
            return new TypeAnnotations(failedConstraints);
        }
    }

    private Constraints() {
    }
}
