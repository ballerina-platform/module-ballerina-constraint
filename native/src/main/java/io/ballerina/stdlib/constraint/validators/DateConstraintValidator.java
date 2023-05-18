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

package io.ballerina.stdlib.constraint.validators;

import io.ballerina.runtime.api.values.BMap;
import io.ballerina.runtime.api.values.BString;
import io.ballerina.stdlib.constraint.InternalValidationException;
import io.ballerina.stdlib.constraint.validators.interfaces.DateValidator;

import java.time.DateTimeException;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import static io.ballerina.stdlib.constraint.Constants.CONSTRAINT_VALID_DATE;
import static io.ballerina.stdlib.constraint.Constants.DATE_RECORD_DAY_BSTRING;
import static io.ballerina.stdlib.constraint.Constants.DATE_RECORD_MONTH_BSTRING;
import static io.ballerina.stdlib.constraint.Constants.DATE_RECORD_YEAR_BSTRING;
import static io.ballerina.stdlib.constraint.Constants.DAY;
import static io.ballerina.stdlib.constraint.Constants.MONTH;
import static io.ballerina.stdlib.constraint.Constants.SYMBOL_DOT;
import static io.ballerina.stdlib.constraint.Constants.SYMBOL_SEPARATOR;
import static io.ballerina.stdlib.constraint.Constants.YEAR;

/**
 * Extern functions for validating date constraints `@constraint:Date` of Ballerina.
 */
public class DateConstraintValidator implements DateValidator {

    private final List<String> failedConstraints;

    public DateConstraintValidator(List<String> failedConstraints) {
        this.failedConstraints = failedConstraints;
    }

    public void validate(BMap<BString, Object> constraints, Object fieldValue, String path) {
        LocalDate date = createLocalDate(fieldValue, path);
        if (date == null) {
            return;
        }
        for (Map.Entry<BString, Object> constraint : constraints.entrySet()) {
            validate(constraint, date, failedConstraints, path);
        }
    }

    LocalDate createLocalDate(Object dateValue, String path) {
        BMap dateMap;
        if (dateValue instanceof BMap) {
            dateMap = (BMap) dateValue;
        } else {
            throw new InternalValidationException("Invalid field type found for constraint:Date");
        }
        Integer[] dateArray = getValidDateFields(dateMap, path);
        if (dateArray.length == 3) {
            try {
                return LocalDate.of(dateArray[0], dateArray[1], dateArray[2]);
            } catch (DateTimeException e) {
                failedConstraints.add(path + SYMBOL_DOT + DAY + SYMBOL_SEPARATOR + CONSTRAINT_VALID_DATE);
            }
        }
        return null;
    }

    Integer[] getValidDateFields(BMap date, String path) {
        Integer year = getValidDateField(date.getIntValue(DATE_RECORD_YEAR_BSTRING), LocalDate.MIN.getYear(),
                LocalDate.MAX.getYear(), path, YEAR);
        Integer month = getValidDateField(date.getIntValue(DATE_RECORD_MONTH_BSTRING), LocalDate.MIN.getMonthValue(),
                LocalDate.MAX.getMonthValue(), path, MONTH);
        Integer day = getValidDateField(date.getIntValue(DATE_RECORD_DAY_BSTRING), LocalDate.MIN.getDayOfMonth(),
                LocalDate.MAX.getDayOfMonth(), path, DAY);
        if (year == null || month == null || day == null) {
            return new Integer[0];
        }
        return new Integer[]{year, month, day};
    }

    Integer getValidDateField(Long yearValue, int minValue, int maxValue, String path, String fieldName) {
        try {
            int year = Math.toIntExact(yearValue);
            if (year < minValue || year > maxValue) {
                failedConstraints.add(path + SYMBOL_DOT + fieldName + SYMBOL_SEPARATOR + CONSTRAINT_VALID_DATE);
                return null;
            }
            return year;
        } catch (ArithmeticException e) {
            failedConstraints.add(path + SYMBOL_DOT + fieldName + SYMBOL_SEPARATOR + CONSTRAINT_VALID_DATE);
            return null;
        }
    }
}
