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

import io.ballerina.runtime.api.values.BMap;
import io.ballerina.runtime.api.values.BTypedesc;
import io.ballerina.stdlib.constraint.annotations.AbstractAnnotations;
import io.ballerina.stdlib.constraint.annotations.RecordFieldAnnotations;
import io.ballerina.stdlib.constraint.annotations.TypeAnnotations;

import java.util.Set;

/**
 * Extern functions for validating constraints.
 */
public class Constraints {

    public static Object validate(Object value, BTypedesc typedesc) {
        AbstractAnnotations annotations = getAnnotationImpl(value);
        try {
            annotations.validate(value, typedesc);
        } catch (Exception e) {
            return ErrorUtils.buildUnexpectedError();
        }
        Set<String> failedConstraints = annotations.getFailedConstraints();
        if (!failedConstraints.isEmpty()) {
            return ErrorUtils.buildValidationError(failedConstraints);
        }
        return null;
    }

    private static AbstractAnnotations getAnnotationImpl(Object value) {
        if (value instanceof BMap) {
            return new RecordFieldAnnotations();
        } else {
            return new TypeAnnotations();
        }
    }
}
