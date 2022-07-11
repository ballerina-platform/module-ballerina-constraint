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

import io.ballerina.projects.DiagnosticResult;
import io.ballerina.projects.Package;
import io.ballerina.projects.PackageCompilation;
import org.testng.Assert;
import org.testng.annotations.Test;

import static io.ballerina.stdlib.constraint.compiler.CompilerPluginTestConstants.ANNOTATION_TAG_ARRAY;
import static io.ballerina.stdlib.constraint.compiler.CompilerPluginTestConstants.ANNOTATION_TAG_FLOAT;
import static io.ballerina.stdlib.constraint.compiler.CompilerPluginTestConstants.ANNOTATION_TAG_INT;
import static io.ballerina.stdlib.constraint.compiler.CompilerPluginTestConstants.ANNOTATION_TAG_NUMBER;
import static io.ballerina.stdlib.constraint.compiler.CompilerPluginTestConstants.ANNOTATION_TAG_STRING;
import static io.ballerina.stdlib.constraint.compiler.CompilerPluginTestConstants.TYPE_ANYDATA_ARRAY;
import static io.ballerina.stdlib.constraint.compiler.CompilerPluginTestConstants.TYPE_BOOLEAN;
import static io.ballerina.stdlib.constraint.compiler.CompilerPluginTestConstants.TYPE_DECIMAL;
import static io.ballerina.stdlib.constraint.compiler.CompilerPluginTestConstants.TYPE_FLOAT;
import static io.ballerina.stdlib.constraint.compiler.CompilerPluginTestConstants.TYPE_INT;
import static io.ballerina.stdlib.constraint.compiler.CompilerPluginTestConstants.TYPE_MAP_OF_ANYDATA;
import static io.ballerina.stdlib.constraint.compiler.CompilerPluginTestConstants.TYPE_NIL;
import static io.ballerina.stdlib.constraint.compiler.CompilerPluginTestConstants.TYPE_STRING;
import static io.ballerina.stdlib.constraint.compiler.CompilerPluginTestConstants.TYPE_TABLE_OF_ANYDATA;
import static io.ballerina.stdlib.constraint.compiler.CompilerPluginTestConstants.TYPE_XML;

/**
 * This class includes tests for Ballerina Constraint compiler plugin.
 */
public class CompilerPluginTest {

    @Test
    public void testValidAnnotations() {
        Package currentPackage = CompilerPluginTestUtils.loadPackage("sample_package_1");
        PackageCompilation compilation = currentPackage.getCompilation();
        DiagnosticResult diagnosticResult = compilation.diagnosticResult();
        Assert.assertEquals(diagnosticResult.errorCount(), 0);
    }

    @Test
    public void testIntAnnotationTagCompatibility() {
        Package currentPackage = CompilerPluginTestUtils.loadPackage("sample_package_2");
        PackageCompilation compilation = currentPackage.getCompilation();
        DiagnosticResult diagnosticResult = compilation.diagnosticResult();
        String[] expectedErrorTypes = new String[]{TYPE_NIL, TYPE_BOOLEAN, TYPE_FLOAT, TYPE_DECIMAL, TYPE_STRING,
                TYPE_XML, TYPE_ANYDATA_ARRAY, TYPE_MAP_OF_ANYDATA, TYPE_TABLE_OF_ANYDATA, TYPE_NIL, TYPE_BOOLEAN,
                TYPE_FLOAT, TYPE_DECIMAL, TYPE_STRING, TYPE_XML, TYPE_ANYDATA_ARRAY, TYPE_MAP_OF_ANYDATA,
                TYPE_TABLE_OF_ANYDATA};
        Assert.assertEquals(diagnosticResult.errorCount(), expectedErrorTypes.length);
        for (int i = 0; i < expectedErrorTypes.length; i++) {
            CompilerPluginTestUtils.assertError101(diagnosticResult, i, ANNOTATION_TAG_INT, expectedErrorTypes[i]);
        }
    }

    @Test
    public void testFloatAnnotationTagCompatibility() {
        Package currentPackage = CompilerPluginTestUtils.loadPackage("sample_package_3");
        PackageCompilation compilation = currentPackage.getCompilation();
        DiagnosticResult diagnosticResult = compilation.diagnosticResult();
        String[] expectedErrorTypes = new String[]{TYPE_NIL, TYPE_BOOLEAN, TYPE_INT, TYPE_DECIMAL, TYPE_STRING,
                TYPE_XML, TYPE_ANYDATA_ARRAY, TYPE_MAP_OF_ANYDATA, TYPE_TABLE_OF_ANYDATA, TYPE_NIL, TYPE_BOOLEAN,
                TYPE_INT, TYPE_DECIMAL, TYPE_STRING, TYPE_XML, TYPE_ANYDATA_ARRAY, TYPE_MAP_OF_ANYDATA,
                TYPE_TABLE_OF_ANYDATA};
        Assert.assertEquals(diagnosticResult.errorCount(), expectedErrorTypes.length);
        for (int i = 0; i < expectedErrorTypes.length; i++) {
            CompilerPluginTestUtils.assertError101(diagnosticResult, i, ANNOTATION_TAG_FLOAT, expectedErrorTypes[i]);
        }
    }

    @Test
    public void testNumberAnnotationTagCompatibility() {
        Package currentPackage = CompilerPluginTestUtils.loadPackage("sample_package_4");
        PackageCompilation compilation = currentPackage.getCompilation();
        DiagnosticResult diagnosticResult = compilation.diagnosticResult();
        String[] expectedErrorTypes = new String[]{TYPE_NIL, TYPE_BOOLEAN, TYPE_STRING, TYPE_XML, TYPE_ANYDATA_ARRAY,
                TYPE_MAP_OF_ANYDATA, TYPE_TABLE_OF_ANYDATA, TYPE_NIL, TYPE_BOOLEAN, TYPE_STRING, TYPE_XML,
                TYPE_ANYDATA_ARRAY, TYPE_MAP_OF_ANYDATA, TYPE_TABLE_OF_ANYDATA};
        Assert.assertEquals(diagnosticResult.errorCount(), expectedErrorTypes.length);
        for (int i = 0; i < expectedErrorTypes.length; i++) {
            CompilerPluginTestUtils.assertError101(diagnosticResult, i, ANNOTATION_TAG_NUMBER, expectedErrorTypes[i]);
        }
    }

    @Test
    public void testStringAnnotationTagCompatibility() {
        Package currentPackage = CompilerPluginTestUtils.loadPackage("sample_package_5");
        PackageCompilation compilation = currentPackage.getCompilation();
        DiagnosticResult diagnosticResult = compilation.diagnosticResult();
        String[] expectedErrorTypes = new String[]{TYPE_NIL, TYPE_BOOLEAN, TYPE_INT, TYPE_FLOAT, TYPE_DECIMAL, TYPE_XML,
                TYPE_ANYDATA_ARRAY, TYPE_MAP_OF_ANYDATA, TYPE_TABLE_OF_ANYDATA, TYPE_NIL, TYPE_BOOLEAN, TYPE_INT,
                TYPE_FLOAT, TYPE_DECIMAL, TYPE_XML, TYPE_ANYDATA_ARRAY, TYPE_MAP_OF_ANYDATA, TYPE_TABLE_OF_ANYDATA};
        Assert.assertEquals(diagnosticResult.errorCount(), expectedErrorTypes.length);
        for (int i = 0; i < expectedErrorTypes.length; i++) {
            CompilerPluginTestUtils.assertError101(diagnosticResult, i, ANNOTATION_TAG_STRING, expectedErrorTypes[i]);
        }
    }

    @Test
    public void testArrayAnnotationTagCompatibility() {
        Package currentPackage = CompilerPluginTestUtils.loadPackage("sample_package_6");
        PackageCompilation compilation = currentPackage.getCompilation();
        DiagnosticResult diagnosticResult = compilation.diagnosticResult();
        String[] expectedErrorTypes = new String[]{TYPE_NIL, TYPE_BOOLEAN, TYPE_INT, TYPE_FLOAT, TYPE_DECIMAL,
                TYPE_STRING, TYPE_XML, TYPE_MAP_OF_ANYDATA, TYPE_TABLE_OF_ANYDATA, TYPE_NIL, TYPE_BOOLEAN, TYPE_INT,
                TYPE_FLOAT, TYPE_DECIMAL, TYPE_STRING, TYPE_XML, TYPE_MAP_OF_ANYDATA, TYPE_TABLE_OF_ANYDATA};
        Assert.assertEquals(diagnosticResult.errorCount(), expectedErrorTypes.length);
        for (int i = 0; i < expectedErrorTypes.length; i++) {
            CompilerPluginTestUtils.assertError101(diagnosticResult, i, ANNOTATION_TAG_ARRAY, expectedErrorTypes[i]);
        }
    }

    @Test
    public void testAnnotationTagCompatibilityForUnionTypes() {
        Package currentPackage = CompilerPluginTestUtils.loadPackage("sample_package_7");
        PackageCompilation compilation = currentPackage.getCompilation();
        DiagnosticResult diagnosticResult = compilation.diagnosticResult();
        Assert.assertEquals(diagnosticResult.errorCount(), 22);
        CompilerPluginTestUtils.assertError101(diagnosticResult, 0, ANNOTATION_TAG_INT, "int?");
        CompilerPluginTestUtils.assertError101(diagnosticResult, 1, ANNOTATION_TAG_INT, "int|float");
        CompilerPluginTestUtils.assertError101(diagnosticResult, 2, ANNOTATION_TAG_FLOAT, "float?");
        CompilerPluginTestUtils.assertError101(diagnosticResult, 3, ANNOTATION_TAG_FLOAT, "float|int");
        CompilerPluginTestUtils.assertError101(diagnosticResult, 4, ANNOTATION_TAG_NUMBER, "decimal?");
        CompilerPluginTestUtils.assertError101(diagnosticResult, 5, ANNOTATION_TAG_NUMBER, "decimal|float?");
        CompilerPluginTestUtils.assertError101(diagnosticResult, 6, ANNOTATION_TAG_NUMBER, "decimal|float|int?");
        CompilerPluginTestUtils.assertError101(diagnosticResult, 7, ANNOTATION_TAG_STRING, "string?");
        CompilerPluginTestUtils.assertError101(diagnosticResult, 8, ANNOTATION_TAG_STRING, "string|int");
        CompilerPluginTestUtils.assertError101(diagnosticResult, 9, ANNOTATION_TAG_ARRAY, "anydata[]?");
        CompilerPluginTestUtils.assertError101(diagnosticResult, 10, ANNOTATION_TAG_ARRAY, "int[]|float[]?");
        CompilerPluginTestUtils.assertError101(diagnosticResult, 11, ANNOTATION_TAG_INT, "int?");
        CompilerPluginTestUtils.assertError101(diagnosticResult, 12, ANNOTATION_TAG_INT, "int|float");
        CompilerPluginTestUtils.assertError101(diagnosticResult, 13, ANNOTATION_TAG_FLOAT, "float?");
        CompilerPluginTestUtils.assertError101(diagnosticResult, 14, ANNOTATION_TAG_FLOAT, "float|int");
        CompilerPluginTestUtils.assertError101(diagnosticResult, 15, ANNOTATION_TAG_NUMBER, "decimal?");
        CompilerPluginTestUtils.assertError101(diagnosticResult, 16, ANNOTATION_TAG_NUMBER, "decimal|float?");
        CompilerPluginTestUtils.assertError101(diagnosticResult, 17, ANNOTATION_TAG_NUMBER, "decimal|float|int?");
        CompilerPluginTestUtils.assertError101(diagnosticResult, 18, ANNOTATION_TAG_STRING, "string?");
        CompilerPluginTestUtils.assertError101(diagnosticResult, 19, ANNOTATION_TAG_STRING, "string|int");
        CompilerPluginTestUtils.assertError101(diagnosticResult, 20, ANNOTATION_TAG_ARRAY, "anydata[]?");
        CompilerPluginTestUtils.assertError101(diagnosticResult, 21, ANNOTATION_TAG_ARRAY, "int[]|float[]?");
    }

    @Test
    public void testIntAnnotationTagConstraintsAvailability() {
        Package currentPackage = CompilerPluginTestUtils.loadPackage("sample_package_8");
        PackageCompilation compilation = currentPackage.getCompilation();
        DiagnosticResult diagnosticResult = compilation.diagnosticResult();
        int expectedErrorCount = 2;
        Assert.assertEquals(diagnosticResult.errorCount(), expectedErrorCount);
        for (int i = 0; i < expectedErrorCount; i++) {
            CompilerPluginTestUtils.assertError102(diagnosticResult, i, ANNOTATION_TAG_INT, TYPE_INT);
        }
    }

    @Test
    public void testFloatAnnotationTagConstraintsAvailability() {
        Package currentPackage = CompilerPluginTestUtils.loadPackage("sample_package_9");
        PackageCompilation compilation = currentPackage.getCompilation();
        DiagnosticResult diagnosticResult = compilation.diagnosticResult();
        int expectedErrorCount = 2;
        Assert.assertEquals(diagnosticResult.errorCount(), expectedErrorCount);
        for (int i = 0; i < expectedErrorCount; i++) {
            CompilerPluginTestUtils.assertError102(diagnosticResult, i, ANNOTATION_TAG_FLOAT, TYPE_FLOAT);
        }
    }

    @Test
    public void testNumberAnnotationTagConstraintsAvailability() {
        Package currentPackage = CompilerPluginTestUtils.loadPackage("sample_package_10");
        PackageCompilation compilation = currentPackage.getCompilation();
        DiagnosticResult diagnosticResult = compilation.diagnosticResult();
        int expectedErrorCount = 2;
        Assert.assertEquals(diagnosticResult.errorCount(), expectedErrorCount);
        for (int i = 0; i < expectedErrorCount; i++) {
            CompilerPluginTestUtils.assertError102(diagnosticResult, i, ANNOTATION_TAG_NUMBER, TYPE_DECIMAL);
        }
    }

    @Test
    public void testStringAnnotationTagConstraintsAvailability() {
        Package currentPackage = CompilerPluginTestUtils.loadPackage("sample_package_11");
        PackageCompilation compilation = currentPackage.getCompilation();
        DiagnosticResult diagnosticResult = compilation.diagnosticResult();
        int expectedErrorCount = 2;
        Assert.assertEquals(diagnosticResult.errorCount(), expectedErrorCount);
        for (int i = 0; i < expectedErrorCount; i++) {
            CompilerPluginTestUtils.assertError102(diagnosticResult, i, ANNOTATION_TAG_STRING, TYPE_STRING);
        }
    }

    @Test
    public void testArrayAnnotationTagConstraintsAvailability() {
        Package currentPackage = CompilerPluginTestUtils.loadPackage("sample_package_12");
        PackageCompilation compilation = currentPackage.getCompilation();
        DiagnosticResult diagnosticResult = compilation.diagnosticResult();
        int expectedErrorCount = 2;
        Assert.assertEquals(diagnosticResult.errorCount(), expectedErrorCount);
        for (int i = 0; i < expectedErrorCount; i++) {
            CompilerPluginTestUtils.assertError102(diagnosticResult, i, ANNOTATION_TAG_ARRAY, TYPE_ANYDATA_ARRAY);
        }
    }

    @Test
    public void testIntAnnotationTagConstraintsCompatibility() {
        Package currentPackage = CompilerPluginTestUtils.loadPackage("sample_package_13");
        PackageCompilation compilation = currentPackage.getCompilation();
        DiagnosticResult diagnosticResult = compilation.diagnosticResult();
        int expectedErrorCount = 4;
        Assert.assertEquals(diagnosticResult.errorCount(), expectedErrorCount);
        for (int i = 0; i < expectedErrorCount; i++) {
            CompilerPluginTestUtils.assertError103(diagnosticResult, i, ANNOTATION_TAG_INT, TYPE_INT);
        }
    }

    @Test
    public void testFloatAnnotationTagConstraintsCompatibility() {
        Package currentPackage = CompilerPluginTestUtils.loadPackage("sample_package_14");
        PackageCompilation compilation = currentPackage.getCompilation();
        DiagnosticResult diagnosticResult = compilation.diagnosticResult();
        int expectedErrorCount = 4;
        Assert.assertEquals(diagnosticResult.errorCount(), expectedErrorCount);
        for (int i = 0; i < expectedErrorCount; i++) {
            CompilerPluginTestUtils.assertError103(diagnosticResult, i, ANNOTATION_TAG_FLOAT, TYPE_FLOAT);
        }
    }

    @Test
    public void testNumberAnnotationTagConstraintsCompatibility() {
        Package currentPackage = CompilerPluginTestUtils.loadPackage("sample_package_15");
        PackageCompilation compilation = currentPackage.getCompilation();
        DiagnosticResult diagnosticResult = compilation.diagnosticResult();
        int expectedErrorCount = 4;
        Assert.assertEquals(diagnosticResult.errorCount(), expectedErrorCount);
        for (int i = 0; i < expectedErrorCount; i++) {
            CompilerPluginTestUtils.assertError103(diagnosticResult, i, ANNOTATION_TAG_NUMBER, TYPE_DECIMAL);
        }
    }

    @Test
    public void testStringAnnotationTagConstraintsCompatibility() {
        Package currentPackage = CompilerPluginTestUtils.loadPackage("sample_package_16");
        PackageCompilation compilation = currentPackage.getCompilation();
        DiagnosticResult diagnosticResult = compilation.diagnosticResult();
        int expectedErrorCount = 4;
        Assert.assertEquals(diagnosticResult.errorCount(), expectedErrorCount);
        for (int i = 0; i < expectedErrorCount; i++) {
            CompilerPluginTestUtils.assertError103(diagnosticResult, i, ANNOTATION_TAG_STRING, TYPE_STRING);
        }
    }

    @Test
    public void testArrayAnnotationTagConstraintsCompatibility() {
        Package currentPackage = CompilerPluginTestUtils.loadPackage("sample_package_17");
        PackageCompilation compilation = currentPackage.getCompilation();
        DiagnosticResult diagnosticResult = compilation.diagnosticResult();
        int expectedErrorCount = 4;
        Assert.assertEquals(diagnosticResult.errorCount(), expectedErrorCount);
        for (int i = 0; i < expectedErrorCount; i++) {
            CompilerPluginTestUtils.assertError103(diagnosticResult, i, ANNOTATION_TAG_ARRAY, TYPE_ANYDATA_ARRAY);
        }
    }

    @Test
    public void testStringAnnotationTagConstraintsValidity() {
        Package currentPackage = CompilerPluginTestUtils.loadPackage("sample_package_18");
        PackageCompilation compilation = currentPackage.getCompilation();
        DiagnosticResult diagnosticResult = compilation.diagnosticResult();
        int expectedErrorCount = 6;
        Assert.assertEquals(diagnosticResult.errorCount(), expectedErrorCount);
        for (int i = 0; i < expectedErrorCount; i++) {
            CompilerPluginTestUtils.assertError104(diagnosticResult, i, ANNOTATION_TAG_STRING, TYPE_STRING);
        }
    }

    @Test
    public void testArrayAnnotationTagConstraintsValidity() {
        Package currentPackage = CompilerPluginTestUtils.loadPackage("sample_package_19");
        PackageCompilation compilation = currentPackage.getCompilation();
        DiagnosticResult diagnosticResult = compilation.diagnosticResult();
        int expectedErrorCount = 6;
        Assert.assertEquals(diagnosticResult.errorCount(), expectedErrorCount);
        for (int i = 0; i < expectedErrorCount; i++) {
            CompilerPluginTestUtils.assertError104(diagnosticResult, i, ANNOTATION_TAG_ARRAY, TYPE_ANYDATA_ARRAY);
        }
    }
}
