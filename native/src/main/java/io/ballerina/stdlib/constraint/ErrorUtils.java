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

import io.ballerina.runtime.api.creators.ErrorCreator;
import io.ballerina.runtime.api.utils.StringUtils;
import io.ballerina.runtime.api.values.BError;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import static io.ballerina.stdlib.constraint.Constants.GENERIC_ERROR;
import static io.ballerina.stdlib.constraint.Constants.SYMBOL_COMMA;
import static io.ballerina.stdlib.constraint.Constants.SYMBOL_DOT;
import static io.ballerina.stdlib.constraint.Constants.SYMBOL_SINGLE_QUOTE;
import static io.ballerina.stdlib.constraint.Constants.TYPE_CONVERSION_ERROR;

/**
 * Utility functions related to errors.
 */
public class ErrorUtils {

    private static final String UNEXPECTED_ERROR_MESSAGE = "Unexpected error found due to typedesc and value mismatch.";
    private static final String TYPE_CONVERSION_ERROR_MESSAGE = "Type conversion failed due to typedesc and value " +
            "mismatch.";
    private static final String VALIDATION_ERROR_MESSAGE_PREFIX = "Validation failed for ";
    private static final String VALIDATION_ERROR_MESSAGE_SUFFIX = " constraint(s)";

    static BError buildUnexpectedError(RuntimeException e) {
        if (e instanceof BError) {
            return createError(UNEXPECTED_ERROR_MESSAGE, (BError) e, GENERIC_ERROR);
        }
        return createGenericError(UNEXPECTED_ERROR_MESSAGE);
    }

    static BError buildValidationError(List<ConstraintErrorInfo> failedConstraintsInfo) {
        List<String> customErrorMsgList = new ArrayList<>();
        List<String> restErrorMsgList = new ArrayList<>();
        List<String> causeMsgList = new ArrayList<>();
        for (ConstraintErrorInfo constraintErrorInfo : failedConstraintsInfo) {
            causeMsgList.add(constraintErrorInfo.getFailedConstraintsWithPath());
            if (constraintErrorInfo.hasMessage()) {
                customErrorMsgList.add(constraintErrorInfo.getMessage());
            } else {
                restErrorMsgList.add(constraintErrorInfo.getFailedConstraintsWithPath());
            }
        }
        if (customErrorMsgList.isEmpty()) {
            return createError(buildDefaultErrorMessage(causeMsgList));
        }
        BError cause = createGenericError(buildDefaultErrorMessage(causeMsgList));
        if (!restErrorMsgList.isEmpty()) {
            customErrorMsgList.add(buildDefaultErrorMessage(restErrorMsgList));
        }
        return createError(buildErrorMessage(customErrorMsgList), cause);
    }

    static String buildDefaultErrorMessage(List<String> failedConstraints) {
        Collections.sort(failedConstraints);
        StringBuilder errorMsg = new StringBuilder(VALIDATION_ERROR_MESSAGE_PREFIX);
        for (String constraint : failedConstraints) {
            errorMsg.append(SYMBOL_SINGLE_QUOTE).append(constraint).append(SYMBOL_SINGLE_QUOTE + SYMBOL_COMMA);
        }
        errorMsg.deleteCharAt(errorMsg.length() - 1);
        errorMsg.append(VALIDATION_ERROR_MESSAGE_SUFFIX).append(SYMBOL_DOT);
        return errorMsg.toString();
    }

    static String buildErrorMessage(List<String> list) {
        int size = list.size();
        StringBuilder builder = new StringBuilder();
        for (int i = 0; i < size; i++) {
            builder.append(trimMessage(list.get(i)));

            if (i < size - 2) {
                builder.append(", ");
            } else if (i == size - 2) {
                builder.append(" and ");
            }
        }
        builder.append(SYMBOL_DOT);
        return builder.toString();
    }

    static String trimMessage(String message) {
        message = message.trim();
        if (message.endsWith(SYMBOL_DOT)) {
            return message.substring(0, message.length() - 1);
        }
        return message;
    }

    static BError buildTypeConversionError(BError err) {
        return createError(TYPE_CONVERSION_ERROR_MESSAGE, err, TYPE_CONVERSION_ERROR);
    }

    static BError createGenericError(String errMessage) {
        return ErrorCreator.createError(ModuleUtils.getModule(), GENERIC_ERROR,
                                        StringUtils.fromString(errMessage), null, null);
    }

    static BError createError(String errMessage) {
        return ErrorCreator.createError(ModuleUtils.getModule(), Constants.VALIDATION_ERROR,
                                        StringUtils.fromString(errMessage), null, null);
    }

    static BError createError(String errMessage, BError err, String errorType) {
        return ErrorCreator.createError(ModuleUtils.getModule(), errorType,
                                        StringUtils.fromString(errMessage), err, null);
    }

    static BError createError(String errMessage, BError err) {
        return ErrorCreator.createError(ModuleUtils.getModule(), Constants.VALIDATION_ERROR,
                                        StringUtils.fromString(errMessage), err, null);
    }
}
