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

package io.ballerina.stdlib.constraint.compiler.annotation.tag;

import java.util.ArrayList;

import static io.ballerina.stdlib.constraint.compiler.Constants.CONSTRAINT_LENGTH;
import static io.ballerina.stdlib.constraint.compiler.Constants.CONSTRAINT_MAX_LENGTH;
import static io.ballerina.stdlib.constraint.compiler.Constants.CONSTRAINT_MIN_LENGTH;

/**
 * The interface to represent the length constraints of the annotation tags.
 */
public interface LengthConstrainedAnnotationTag extends AnnotationTag {

    @Override
    default boolean haveCompatibleConstraints(ArrayList<String> constraints) {
        return !(constraints.contains(CONSTRAINT_LENGTH) && constraints.contains(CONSTRAINT_MIN_LENGTH) ||
                constraints.contains(CONSTRAINT_LENGTH) && constraints.contains(CONSTRAINT_MAX_LENGTH));
    }

    default boolean isValidConstraintValue(String constraintField, String constraintValue) {
        return !CONSTRAINT_LENGTH.equals(constraintField) && !CONSTRAINT_MIN_LENGTH.equals(constraintField) &&
                !CONSTRAINT_MAX_LENGTH.equals(constraintField) || Double.parseDouble(constraintValue) > 0;
    }
}
