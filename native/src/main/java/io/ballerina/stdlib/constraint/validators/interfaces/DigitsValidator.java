/*
 * Copyright (c) 2023, WSO2 LLC. (http://www.wso2.com) All Rights Reserved.
 *
 * WSO2 LLC. licenses this file to you under the Apache License,
 * Version 2.0 (the "License"); you may not use this file except
 * in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

package io.ballerina.stdlib.constraint.validators.interfaces;

import io.ballerina.runtime.api.values.BMap;
import io.ballerina.runtime.api.values.BString;
import io.ballerina.stdlib.constraint.ConstraintErrorInfo;
import io.ballerina.stdlib.constraint.InternalValidationException;

import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import static io.ballerina.stdlib.constraint.Constants.CONSTRAINT_MAX_DIGITS;
import static io.ballerina.stdlib.constraint.Constants.CONSTRAINT_MAX_FRACTION_DIGITS;
import static io.ballerina.stdlib.constraint.Constants.CONSTRAINT_MAX_INTEGER_DIGITS;
import static io.ballerina.stdlib.constraint.Constants.DOT_SEPARATOR;
import static io.ballerina.stdlib.constraint.Constants.MESSAGE;
import static io.ballerina.stdlib.constraint.Constants.SCIENTIFIC_NOTATION_REGEX;
import static io.ballerina.stdlib.constraint.Constants.SYMBOL_SEPARATOR;
import static io.ballerina.stdlib.constraint.Constants.VALUE;
import static io.ballerina.stdlib.constraint.Constants.ZERO_STRING;

public interface DigitsValidator {

    default void validate(Map.Entry<BString, Object> constraint, Object fieldValue, boolean isMemberValue,
                          List<ConstraintErrorInfo> failedConstraints, String path) {
        Object constraintValue = constraint.getValue();
        String message = null;
        if (constraintValue instanceof BMap) {
            message = ((BMap) constraintValue).getStringValue(MESSAGE).getValue();
            constraintValue = ((BMap) constraintValue).get(VALUE);
        }
        switch (constraint.getKey().getValue()) {
            case CONSTRAINT_MAX_DIGITS:
                if (!validateMaxDigits(fieldValue, constraintValue)) {
                    failedConstraints.add(new ConstraintErrorInfo(path, message, CONSTRAINT_MAX_DIGITS, isMemberValue));
                }
                break;
            case CONSTRAINT_MAX_INTEGER_DIGITS:
                if (!validateMaxIntegerDigits(fieldValue, constraintValue)) {
                    failedConstraints.add(new ConstraintErrorInfo(path, message, CONSTRAINT_MAX_INTEGER_DIGITS,
                            isMemberValue));
                }
                break;
            case CONSTRAINT_MAX_FRACTION_DIGITS:
                if (!validateMaxFractionDigits(fieldValue, constraintValue)) {
                    failedConstraints.add(new ConstraintErrorInfo(path, message, CONSTRAINT_MAX_FRACTION_DIGITS,
                            isMemberValue));
                }
                break;
            default:
                break;
        }
    }

    default void checkDigitsConstraintValue(Map.Entry<BString, Object> constraint, String path) {
        Object constraintValue = constraint.getValue() instanceof BMap ? ((BMap) constraint.getValue()).get(VALUE) :
                constraint.getValue();
        switch (constraint.getKey().getValue()) {
            case CONSTRAINT_MAX_DIGITS:
            case CONSTRAINT_MAX_INTEGER_DIGITS:
            case CONSTRAINT_MAX_FRACTION_DIGITS:
                long constraintLongValue = (long) constraintValue;
                String constraintField = constraint.getKey().getValue();
                if (constraintLongValue <= 0) {
                    throw new InternalValidationException("invalid value found for " + path + SYMBOL_SEPARATOR +
                            constraintField + " constraint. Digits constraints should be positive");
                }
                break;
            default:
                break;
        }
    }

    record DigitParts(int integerDigits, int fractionDigits) {
    }

    default DigitParts getDigitPartsFromDouble(double value) {
        String valueString = Double.toString(value);
        if (valueString.matches(SCIENTIFIC_NOTATION_REGEX)) {
            return getDigitPartsFromScientificNotation(value, valueString);
        } else {
            return getDigitPartsFromString(value, valueString);
        }
    }

    private static DigitParts getDigitPartsFromString(double value, String valueString) {
        String[] parts = valueString.split(DOT_SEPARATOR);
        int intDigits = value < 0 ? parts[0].length() - 1 : parts[0].length();
        if (parts.length == 1) {
            return new DigitParts(intDigits, 0);
        } else {
            return new DigitParts(intDigits, parts[1].length());
        }
    }

    private static DigitParts getDigitPartsFromScientificNotation(double value, String valueString) {
        Pattern pattern = Pattern.compile(SCIENTIFIC_NOTATION_REGEX);
        Matcher matcher = pattern.matcher(valueString);
        int intDigits = 0;
        int fractionDigits = 0;
        if (matcher.matches()) {
            String groupA = matcher.group(1);
            String groupB = matcher.group(2);
            String groupC = matcher.group(3);

            int countA = value < 0 ? groupA.length() - 1 : groupA.length();
            int countB = groupB.equals(ZERO_STRING) ? 0 : groupB.length();
            int intC = Integer.parseInt(groupC);

            if (intC > 0) {
                intDigits = countA + Math.min(countB, intC);
                fractionDigits = countB - Math.min(countB, intC);
            } else {
                intDigits = Math.max(1, countA + intC);
                fractionDigits = countB - intC;
            }
        }
        return new DigitParts(intDigits, fractionDigits);
    }

    boolean validateMaxDigits(Object fieldValue, Object constraintValue);

    boolean validateMaxIntegerDigits(Object fieldValue, Object constraintValue);

    boolean validateMaxFractionDigits(Object fieldValue, Object constraintValue);
}
