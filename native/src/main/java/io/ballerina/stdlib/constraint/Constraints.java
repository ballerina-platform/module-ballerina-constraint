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
import io.ballerina.runtime.api.values.BString;
import io.ballerina.runtime.api.values.BTypedesc;
import io.ballerina.stdlib.constraint.attachments.RecordFieldAttachment;

import java.util.HashSet;
import java.util.Set;

/**
 * Extern functions for validating constraints.
 */
public class Constraints {

    @SuppressWarnings({"unchecked", "unused"})
    public static Object validate(Object value, BTypedesc typedesc) {
        Set<String> failedConstraints = new HashSet<>();
        if (value instanceof BMap) {
            new RecordFieldAttachment().validateRecord((BMap<BString, Object>) value, typedesc, failedConstraints);
        }

        if (!failedConstraints.isEmpty()) {
            return ErrorUtils.buildError(failedConstraints);
        }
        return null;
    }
}
