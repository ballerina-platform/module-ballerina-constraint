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

import static io.ballerina.stdlib.constraint.Constants.SYMBOL_SEPARATOR;
import static io.ballerina.stdlib.constraint.Constants.SYMBOL_SINGLE_QUOTE;

/**
 * Represents a constraint violation error information.
 */
public class ConstraintErrorInfo {
    final String path;
    final String message;
    final String failedConstraint;
    final boolean onMemberType;

    public ConstraintErrorInfo(String path, String message, String failedConstraint) {
        this.path = path;
        this.message = message;
        this.failedConstraint = failedConstraint;
        this.onMemberType = false;
    }

    public ConstraintErrorInfo(String path, String message, String failedConstraint, boolean onMemberType) {
        this.path = path;
        this.message = message;
        this.failedConstraint = failedConstraint;
        this.onMemberType = onMemberType;
    }

    public String getPath() {
        return path;
    }

    public String getMessage() {
        if (message != null && onMemberType) {
            return SYMBOL_SINGLE_QUOTE + path + SYMBOL_SINGLE_QUOTE + SYMBOL_SEPARATOR + message;
        }
        return message;
    }

    public boolean hasMessage() {
        return message != null;
    }

    public String getFailedConstraintsWithPath() {
        return path + SYMBOL_SEPARATOR + failedConstraint;
    }
}
