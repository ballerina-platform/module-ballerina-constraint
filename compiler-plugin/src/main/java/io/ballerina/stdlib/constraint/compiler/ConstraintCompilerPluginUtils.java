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
import io.ballerina.compiler.syntax.tree.BasicLiteralNode;
import io.ballerina.compiler.syntax.tree.ExpressionNode;
import io.ballerina.compiler.syntax.tree.MappingConstructorExpressionNode;
import io.ballerina.compiler.syntax.tree.MappingFieldNode;
import io.ballerina.compiler.syntax.tree.NodeList;
import io.ballerina.compiler.syntax.tree.NodeLocation;
import io.ballerina.compiler.syntax.tree.SeparatedNodeList;
import io.ballerina.compiler.syntax.tree.SpecificFieldNode;
import io.ballerina.compiler.syntax.tree.UnaryExpressionNode;
import io.ballerina.compiler.syntax.tree.UnionTypeDescriptorNode;
import io.ballerina.projects.plugins.SyntaxNodeAnalysisContext;
import io.ballerina.tools.diagnostics.DiagnosticFactory;
import io.ballerina.tools.diagnostics.DiagnosticInfo;

import java.util.ArrayList;
import java.util.Optional;

import static io.ballerina.stdlib.constraint.compiler.Constants.MODULE_NAME;
import static io.ballerina.stdlib.constraint.compiler.Constants.SYMBOL_COLON;
import static io.ballerina.stdlib.constraint.compiler.Constants.SYMBOL_DECIMAL;
import static io.ballerina.stdlib.constraint.compiler.Constants.SYMBOL_NEW_LINE;
import static io.ballerina.stdlib.constraint.compiler.ConstraintDiagnosticCodes.CONSTRAINT_101;
import static io.ballerina.stdlib.constraint.compiler.ConstraintDiagnosticCodes.CONSTRAINT_102;
import static io.ballerina.stdlib.constraint.compiler.ConstraintDiagnosticCodes.CONSTRAINT_103;
import static io.ballerina.stdlib.constraint.compiler.ConstraintDiagnosticCodes.CONSTRAINT_104;

/**
 * The compiler plugin utility functions.
 */
public class ConstraintCompilerPluginUtils {

    private static final ConstraintCompatibilityMatrix matrix = new ConstraintCompatibilityMatrix();

    static void populateFieldTypeList(UnionTypeDescriptorNode node, ArrayList<String> fieldTypeList) {
        fieldTypeList.add(node.rightTypeDesc().toString().trim());
        if (node.leftTypeDesc() instanceof UnionTypeDescriptorNode) {
            populateFieldTypeList((UnionTypeDescriptorNode) node.leftTypeDesc(), fieldTypeList);
        } else {
            fieldTypeList.add(node.leftTypeDesc().toString().trim());
        }
    }

    static void validateConstraints(SyntaxNodeAnalysisContext ctx, NodeList<AnnotationNode> annotationNodes,
                                    String fieldType, ArrayList<String> fieldTypeList) {
        for (AnnotationNode annotationNode : annotationNodes) {
            String[] annotationParts = annotationNode.annotReference().toString().trim().split(SYMBOL_COLON);
            if (annotationParts[0].equals(MODULE_NAME)) {
                String annotationTag = annotationParts[1];
                checkAnnotationTagCompatibility(ctx, annotationNode, annotationTag, fieldType, fieldTypeList);
                checkAnnotationConstraintsAvailability(ctx, annotationNode, annotationTag, fieldType);
                checkAnnotationConstraintsCompatibility(ctx, annotationNode, annotationTag, fieldType);
                checkAnnotationConstraintsValidity(ctx, annotationNode, annotationTag, fieldType);
            }
        }
    }

    private static void checkAnnotationTagCompatibility(SyntaxNodeAnalysisContext ctx, AnnotationNode annotationNode,
                                                        String annotationTag, String fieldType,
                                                        ArrayList<String> fieldTypeList) {
        for (String type : fieldTypeList) {
            if (!matrix.isAnnotationTagCompatible(annotationTag, type)) {
                reportAnnotationTagIncompatibility(ctx, annotationTag, fieldType, annotationNode.location());
                break;
            }
        }
    }

    private static void checkAnnotationConstraintsAvailability(SyntaxNodeAnalysisContext ctx,
                                                               AnnotationNode annotationNode, String annotationTag,
                                                               String fieldType) {
        Optional<MappingConstructorExpressionNode> value = annotationNode.annotValue();
        if (value.filter(node -> node.fields().size() > 0).isEmpty()) {
            reportConstraintsUnavailability(ctx, annotationTag, fieldType, annotationNode.location());
        }
    }

    private static void checkAnnotationConstraintsCompatibility(SyntaxNodeAnalysisContext ctx,
                                                                AnnotationNode annotationNode, String annotationTag,
                                                                String fieldType) {
        Optional<MappingConstructorExpressionNode> value = annotationNode.annotValue();
        if (value.isPresent()) {
            ArrayList<String> constraintsList = new ArrayList<>();
            SeparatedNodeList<MappingFieldNode> constraints = value.get().fields();
            for (MappingFieldNode constraint : constraints) {
                SpecificFieldNode node = (SpecificFieldNode) constraint;
                constraintsList.add(node.fieldName().toString().trim());
            }
            if (!matrix.isAnnotationConstraintsCompatible(annotationTag, constraintsList)) {
                reportConstraintsIncompatibility(ctx, annotationTag, fieldType, annotationNode.location());
            }
        }
    }

    private static void checkAnnotationConstraintsValidity(SyntaxNodeAnalysisContext ctx, AnnotationNode annotationNode,
                                                           String annotationTag, String fieldType) {
        Optional<MappingConstructorExpressionNode> value = annotationNode.annotValue();
        if (value.isPresent()) {
            SeparatedNodeList<MappingFieldNode> constraints = value.get().fields();
            for (MappingFieldNode constraint : constraints) {
                SpecificFieldNode node = (SpecificFieldNode) constraint;
                Optional<ExpressionNode> valueExpr = node.valueExpr();
                if (valueExpr.isPresent() && (valueExpr.get() instanceof BasicLiteralNode ||
                                                valueExpr.get() instanceof UnaryExpressionNode)) {
                    String constraintValue = valueExpr.get().toString().trim()
                            .replaceAll(SYMBOL_NEW_LINE, "")
                            .replaceAll(SYMBOL_DECIMAL, "");
                    String constraintField = node.fieldName().toString().trim();
                    if (!matrix.isAnnotationConstraintsValid(annotationTag, constraintField, constraintValue)) {
                        reportConstraintsInvalidity(ctx, annotationTag, fieldType, annotationNode.location());
                    }
                }
            }
        }
    }

    private static void reportAnnotationTagIncompatibility(SyntaxNodeAnalysisContext ctx, String annotationTag,
                                                           String fieldType, NodeLocation nodeLocation) {
        DiagnosticInfo diagnosticInfo = new DiagnosticInfo(CONSTRAINT_101.getCode(),
                String.format(CONSTRAINT_101.getMessage(), annotationTag, fieldType), CONSTRAINT_101.getSeverity());
        ctx.reportDiagnostic(DiagnosticFactory.createDiagnostic(diagnosticInfo, nodeLocation));
    }

    private static void reportConstraintsUnavailability(SyntaxNodeAnalysisContext ctx, String annotationTag,
                                                        String fieldType, NodeLocation nodeLocation) {
        DiagnosticInfo diagnosticInfo = new DiagnosticInfo(CONSTRAINT_102.getCode(),
                String.format(CONSTRAINT_102.getMessage(), annotationTag, fieldType), CONSTRAINT_102.getSeverity());
        ctx.reportDiagnostic(DiagnosticFactory.createDiagnostic(diagnosticInfo, nodeLocation));
    }

    private static void reportConstraintsIncompatibility(SyntaxNodeAnalysisContext ctx, String annotationTag,
                                                         String fieldType, NodeLocation location) {
        DiagnosticInfo diagnosticInfo = new DiagnosticInfo(CONSTRAINT_103.getCode(),
                String.format(CONSTRAINT_103.getMessage(), annotationTag, fieldType), CONSTRAINT_103.getSeverity());
        ctx.reportDiagnostic(DiagnosticFactory.createDiagnostic(diagnosticInfo, location));
    }

    private static void reportConstraintsInvalidity(SyntaxNodeAnalysisContext ctx, String annotationTag,
                                                    String fieldType, NodeLocation location) {
        DiagnosticInfo diagnosticInfo = new DiagnosticInfo(CONSTRAINT_104.getCode(),
                String.format(CONSTRAINT_104.getMessage(), annotationTag, fieldType), CONSTRAINT_104.getSeverity());
        ctx.reportDiagnostic(DiagnosticFactory.createDiagnostic(diagnosticInfo, location));
    }
}
