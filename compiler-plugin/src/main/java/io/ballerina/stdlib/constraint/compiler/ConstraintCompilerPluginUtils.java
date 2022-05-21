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

import io.ballerina.compiler.syntax.tree.AnnotationNode;
import io.ballerina.compiler.syntax.tree.ExpressionNode;
import io.ballerina.compiler.syntax.tree.MappingConstructorExpressionNode;
import io.ballerina.compiler.syntax.tree.MappingFieldNode;
import io.ballerina.compiler.syntax.tree.NodeLocation;
import io.ballerina.compiler.syntax.tree.SeparatedNodeList;
import io.ballerina.compiler.syntax.tree.SpecificFieldNode;
import io.ballerina.projects.plugins.SyntaxNodeAnalysisContext;
import io.ballerina.tools.diagnostics.DiagnosticFactory;
import io.ballerina.tools.diagnostics.DiagnosticInfo;

import java.util.ArrayList;
import java.util.Optional;

import static io.ballerina.stdlib.constraint.compiler.ConstraintDiagnosticCodes.CONSTRAINT_101;
import static io.ballerina.stdlib.constraint.compiler.ConstraintDiagnosticCodes.CONSTRAINT_102;
import static io.ballerina.stdlib.constraint.compiler.ConstraintDiagnosticCodes.CONSTRAINT_103;
import static io.ballerina.stdlib.constraint.compiler.ConstraintDiagnosticCodes.CONSTRAINT_104;

/**
 * The compiler plugin utility functions.
 */
public class ConstraintCompilerPluginUtils {

    static void checkAnnotationTagCompatibility(SyntaxNodeAnalysisContext ctx, AnnotationNode annotationNode,
                                                String annotationTag, String fieldType) {
        if (!isAnnotationTagCompatible(annotationTag, fieldType)) {
            reportAnnotationTagIncompatibility(ctx, annotationTag, fieldType, annotationNode.location());
        }
    }

    private static boolean isAnnotationTagCompatible(String annotationTag, String fieldType) {
        switch (annotationTag) {
            case Constants.ANNOTATION_TAG_INT:
                return fieldType.equals(Constants.TYPE_INT);
            case Constants.ANNOTATION_TAG_FLOAT:
                return fieldType.equals(Constants.TYPE_FLOAT);
            case Constants.ANNOTATION_TAG_NUMBER:
                return fieldType.equals(Constants.TYPE_INT) || fieldType.equals(Constants.TYPE_FLOAT) ||
                        fieldType.equals(Constants.TYPE_DECIMAL);
            case Constants.ANNOTATION_TAG_ARRAY:
                return fieldType.endsWith(Constants.SYMBOL_ARRAY);
            case Constants.ANNOTATION_TAG_STRING:
                return fieldType.equals(Constants.TYPE_STRING);
            default:
                return false;
        }
    }

    static void checkAnnotationConstraintsAvailability(SyntaxNodeAnalysisContext ctx, AnnotationNode annotationNode,
                                                       String annotationTag) {
        Optional<MappingConstructorExpressionNode> value = annotationNode.annotValue();
        if (value.filter(node -> node.fields().size() > 0).isEmpty()) {
            reportConstraintsUnavailability(ctx, annotationTag, annotationNode.location());
        }
    }

    static void checkAnnotationConstraintsCompatibility(SyntaxNodeAnalysisContext ctx, AnnotationNode annotationNode,
                                                        String annotationTag) {
        Optional<MappingConstructorExpressionNode> value = annotationNode.annotValue();
        if (value.isPresent()) {
            ArrayList<String> constraintsList = new ArrayList<>();
            SeparatedNodeList<MappingFieldNode> constraints = value.get().fields();
            for (MappingFieldNode constraint : constraints) {
                SpecificFieldNode node = (SpecificFieldNode) constraint;
                constraintsList.add(node.fieldName().toString().trim());
            }
            if (!isAnnotationConstraintsCompatible(annotationTag, constraintsList)) {
                reportConstraintsIncompatibility(ctx, annotationTag, annotationNode.location());
            }
        }
    }

    private static boolean isAnnotationConstraintsCompatible(String annotationTag, ArrayList<String> constraints) {
        switch (annotationTag) {
            case Constants.ANNOTATION_TAG_INT:
            case Constants.ANNOTATION_TAG_FLOAT:
            case Constants.ANNOTATION_TAG_NUMBER:
                return !(constraints.contains(Constants.CONSTRAINT_MIN_VALUE) &&
                        constraints.contains(Constants.CONSTRAINT_MIN_VALUE_EXCLUSIVE) ||
                        constraints.contains(Constants.CONSTRAINT_MAX_VALUE) &&
                                constraints.contains(Constants.CONSTRAINT_MAX_VALUE_EXCLUSIVE));
            case Constants.ANNOTATION_TAG_ARRAY:
            case Constants.ANNOTATION_TAG_STRING:
                return !(constraints.contains(Constants.CONSTRAINT_LENGTH) &&
                        constraints.contains(Constants.CONSTRAINT_MIN_LENGTH) ||
                        constraints.contains(Constants.CONSTRAINT_LENGTH) &&
                                constraints.contains(Constants.CONSTRAINT_MAX_LENGTH));
            default:
                return false;
        }
    }

    static void checkAnnotationConstraintsValidity(SyntaxNodeAnalysisContext ctx, AnnotationNode annotationNode,
                                                   String annotationTag, String fieldType) {
        Optional<MappingConstructorExpressionNode> value = annotationNode.annotValue();
        if (value.isPresent()) {
            SeparatedNodeList<MappingFieldNode> constraints = value.get().fields();
            for (MappingFieldNode constraint : constraints) {
                SpecificFieldNode node = (SpecificFieldNode) constraint;
                Optional<ExpressionNode> valueExpr = node.valueExpr();
                if (valueExpr.isPresent()) {
                    String constraintValue = valueExpr.get().toString().trim()
                            .replaceAll(Constants.SYMBOL_NEW_LINE, "");
                    if (!isAnnotationConstraintsValid(annotationTag, Long.parseLong(constraintValue))) {
                        reportConstraintsInvalidity(ctx, annotationTag, fieldType, annotationNode.location());
                    }
                }
            }
        }
    }

    private static boolean isAnnotationConstraintsValid(String annotationTag, long constraintValue) {
        switch (annotationTag) {
            case Constants.ANNOTATION_TAG_ARRAY:
            case Constants.ANNOTATION_TAG_STRING:
                return constraintValue >= 0;
            default:
                return true;
        }
    }

    static void reportAnnotationTagIncompatibility(SyntaxNodeAnalysisContext ctx, String annotationTag,
                                                   String fieldType, NodeLocation nodeLocation) {
        DiagnosticInfo diagnosticInfo = new DiagnosticInfo(CONSTRAINT_101.getCode(),
                String.format(CONSTRAINT_101.getMessage(), annotationTag, fieldType), CONSTRAINT_101.getSeverity());
        ctx.reportDiagnostic(DiagnosticFactory.createDiagnostic(diagnosticInfo, nodeLocation));
    }

    static void reportConstraintsUnavailability(SyntaxNodeAnalysisContext ctx, String annotationTag,
                                                NodeLocation nodeLocation) {
        DiagnosticInfo diagnosticInfo = new DiagnosticInfo(CONSTRAINT_102.getCode(),
                String.format(CONSTRAINT_102.getMessage(), annotationTag), CONSTRAINT_102.getSeverity());
        ctx.reportDiagnostic(DiagnosticFactory.createDiagnostic(diagnosticInfo, nodeLocation));
    }

    static void reportConstraintsIncompatibility(SyntaxNodeAnalysisContext ctx, String annotationTag,
                                                 NodeLocation location) {
        DiagnosticInfo diagnosticInfo = new DiagnosticInfo(CONSTRAINT_103.getCode(),
                String.format(CONSTRAINT_103.getMessage(), annotationTag), CONSTRAINT_103.getSeverity());
        ctx.reportDiagnostic(DiagnosticFactory.createDiagnostic(diagnosticInfo, location));
    }

    static void reportConstraintsInvalidity(SyntaxNodeAnalysisContext ctx, String annotationTag, String fieldType,
                                            NodeLocation location) {
        DiagnosticInfo diagnosticInfo = new DiagnosticInfo(CONSTRAINT_104.getCode(),
                String.format(CONSTRAINT_104.getMessage(), fieldType, annotationTag), CONSTRAINT_104.getSeverity());
        ctx.reportDiagnostic(DiagnosticFactory.createDiagnostic(diagnosticInfo, location));
    }
}
