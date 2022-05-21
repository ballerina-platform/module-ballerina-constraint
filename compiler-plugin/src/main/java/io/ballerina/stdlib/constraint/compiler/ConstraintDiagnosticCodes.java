/*
 * Copyright (c) 2021 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
 *
 * WSO2 Inc. licenses this file to you under the Apache License,
 * Version 2.0 (the "License"); you may not use this file except
 * in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

package io.ballerina.stdlib.constraint.compiler;

import io.ballerina.tools.diagnostics.DiagnosticSeverity;

import static io.ballerina.tools.diagnostics.DiagnosticSeverity.ERROR;

/**
 * The {@code DiagnosticCodes} for Ballerina Constraint package.
 */
public enum ConstraintDiagnosticCodes {

    CONSTRAINT_101("CONSTRAINT_101", "invalid constraint annotation '@%s' on type '%s'", ERROR),
    CONSTRAINT_102("CONSTRAINT_102", "no constraints found on annotation '@%s'", ERROR),
    CONSTRAINT_103("CONSTRAINT_103", "incompatible constraints found on annotation '@%s'", ERROR),
    CONSTRAINT_104("CONSTRAINT_104", "invalid value for the constraint(s) on annotation '@%s'", ERROR);

    private final String code;
    private final String message;
    private final DiagnosticSeverity severity;

    ConstraintDiagnosticCodes(String code, String message, DiagnosticSeverity severity) {
        this.code = code;
        this.message = message;
        this.severity = severity;
    }

    public String getCode() {
        return code;
    }

    public String getMessage() {
        return message;
    }

    public DiagnosticSeverity getSeverity() {
        return severity;
    }
}
