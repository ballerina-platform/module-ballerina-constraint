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

package io.ballerina.stdlib.constraint.compiler;

import io.ballerina.stdlib.constraint.compiler.annotation.tag.AnnotationTag;
import io.ballerina.stdlib.constraint.compiler.annotation.tag.AnnotationTagArray;
import io.ballerina.stdlib.constraint.compiler.annotation.tag.AnnotationTagFloat;
import io.ballerina.stdlib.constraint.compiler.annotation.tag.AnnotationTagInt;
import io.ballerina.stdlib.constraint.compiler.annotation.tag.AnnotationTagNumber;
import io.ballerina.stdlib.constraint.compiler.annotation.tag.AnnotationTagString;
import io.ballerina.stdlib.constraint.compiler.annotation.tag.LengthConstrainedAnnotationTag;

import java.util.ArrayList;
import java.util.HashMap;

import static io.ballerina.stdlib.constraint.compiler.Constants.ANNOTATION_TAG_ARRAY;
import static io.ballerina.stdlib.constraint.compiler.Constants.ANNOTATION_TAG_FLOAT;
import static io.ballerina.stdlib.constraint.compiler.Constants.ANNOTATION_TAG_INT;
import static io.ballerina.stdlib.constraint.compiler.Constants.ANNOTATION_TAG_NUMBER;
import static io.ballerina.stdlib.constraint.compiler.Constants.ANNOTATION_TAG_STRING;

/**
 * The compatibility matrix of the annotation tags.
 */
public class ConstraintCompatibilityMatrix {

    private static final HashMap<String, AnnotationTag> matrix = new HashMap<>();

    ConstraintCompatibilityMatrix() {
        matrix.put(ANNOTATION_TAG_INT, new AnnotationTagInt());
        matrix.put(ANNOTATION_TAG_FLOAT, new AnnotationTagFloat());
        matrix.put(ANNOTATION_TAG_NUMBER, new AnnotationTagNumber());
        matrix.put(ANNOTATION_TAG_STRING, new AnnotationTagString());
        matrix.put(ANNOTATION_TAG_ARRAY, new AnnotationTagArray());
    }

    boolean isAnnotationTagCompatible(String annotationTag, String fieldType) {
        return matrix.get(annotationTag).isCompatibleFieldType(fieldType);
    }

    boolean isAnnotationConstraintsCompatible(String annotationTag, ArrayList<String> constraints) {
        return matrix.get(annotationTag).haveCompatibleConstraints(constraints);
    }

    boolean isAnnotationConstraintsValid(String annotationTag, String constraintField, String constraintValue) {
        AnnotationTag tag = matrix.get(annotationTag);
        return !(tag instanceof LengthConstrainedAnnotationTag) ||
                ((LengthConstrainedAnnotationTag) tag).isValidConstraintValue(constraintField, constraintValue);
    }
}
