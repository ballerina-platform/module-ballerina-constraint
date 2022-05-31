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
        Assert.assertEquals(diagnosticResult.errorCount(), 9);
        CompilerPluginTestUtils.assertError101(diagnosticResult, 0, ANNOTATION_TAG_INT, TYPE_NIL);
        CompilerPluginTestUtils.assertError101(diagnosticResult, 1, ANNOTATION_TAG_INT, TYPE_BOOLEAN);
        CompilerPluginTestUtils.assertError101(diagnosticResult, 2, ANNOTATION_TAG_INT, TYPE_FLOAT);
        CompilerPluginTestUtils.assertError101(diagnosticResult, 3, ANNOTATION_TAG_INT, TYPE_DECIMAL);
        CompilerPluginTestUtils.assertError101(diagnosticResult, 4, ANNOTATION_TAG_INT, TYPE_STRING);
        CompilerPluginTestUtils.assertError101(diagnosticResult, 5, ANNOTATION_TAG_INT, TYPE_XML);
        CompilerPluginTestUtils.assertError101(diagnosticResult, 6, ANNOTATION_TAG_INT, TYPE_ANYDATA_ARRAY);
        CompilerPluginTestUtils.assertError101(diagnosticResult, 7, ANNOTATION_TAG_INT, TYPE_MAP_OF_ANYDATA);
        CompilerPluginTestUtils.assertError101(diagnosticResult, 8, ANNOTATION_TAG_INT, TYPE_TABLE_OF_ANYDATA);
    }

    @Test
    public void testFloatAnnotationTagCompatibility() {
        Package currentPackage = CompilerPluginTestUtils.loadPackage("sample_package_3");
        PackageCompilation compilation = currentPackage.getCompilation();
        DiagnosticResult diagnosticResult = compilation.diagnosticResult();
        Assert.assertEquals(diagnosticResult.errorCount(), 9);
        CompilerPluginTestUtils.assertError101(diagnosticResult, 0, ANNOTATION_TAG_FLOAT, TYPE_NIL);
        CompilerPluginTestUtils.assertError101(diagnosticResult, 1, ANNOTATION_TAG_FLOAT, TYPE_BOOLEAN);
        CompilerPluginTestUtils.assertError101(diagnosticResult, 2, ANNOTATION_TAG_FLOAT, TYPE_INT);
        CompilerPluginTestUtils.assertError101(diagnosticResult, 3, ANNOTATION_TAG_FLOAT, TYPE_DECIMAL);
        CompilerPluginTestUtils.assertError101(diagnosticResult, 4, ANNOTATION_TAG_FLOAT, TYPE_STRING);
        CompilerPluginTestUtils.assertError101(diagnosticResult, 5, ANNOTATION_TAG_FLOAT, TYPE_XML);
        CompilerPluginTestUtils.assertError101(diagnosticResult, 6, ANNOTATION_TAG_FLOAT, TYPE_ANYDATA_ARRAY);
        CompilerPluginTestUtils.assertError101(diagnosticResult, 7, ANNOTATION_TAG_FLOAT, TYPE_MAP_OF_ANYDATA);
        CompilerPluginTestUtils.assertError101(diagnosticResult, 8, ANNOTATION_TAG_FLOAT, TYPE_TABLE_OF_ANYDATA);
    }

    @Test
    public void testNumberAnnotationTagCompatibility() {
        Package currentPackage = CompilerPluginTestUtils.loadPackage("sample_package_4");
        PackageCompilation compilation = currentPackage.getCompilation();
        DiagnosticResult diagnosticResult = compilation.diagnosticResult();
        Assert.assertEquals(diagnosticResult.errorCount(), 7);
        CompilerPluginTestUtils.assertError101(diagnosticResult, 0, ANNOTATION_TAG_NUMBER, TYPE_NIL);
        CompilerPluginTestUtils.assertError101(diagnosticResult, 1, ANNOTATION_TAG_NUMBER, TYPE_BOOLEAN);
        CompilerPluginTestUtils.assertError101(diagnosticResult, 2, ANNOTATION_TAG_NUMBER, TYPE_STRING);
        CompilerPluginTestUtils.assertError101(diagnosticResult, 3, ANNOTATION_TAG_NUMBER, TYPE_XML);
        CompilerPluginTestUtils.assertError101(diagnosticResult, 4, ANNOTATION_TAG_NUMBER, TYPE_ANYDATA_ARRAY);
        CompilerPluginTestUtils.assertError101(diagnosticResult, 5, ANNOTATION_TAG_NUMBER, TYPE_MAP_OF_ANYDATA);
        CompilerPluginTestUtils.assertError101(diagnosticResult, 6, ANNOTATION_TAG_NUMBER, TYPE_TABLE_OF_ANYDATA);
    }

    @Test
    public void testStringAnnotationTagCompatibility() {
        Package currentPackage = CompilerPluginTestUtils.loadPackage("sample_package_5");
        PackageCompilation compilation = currentPackage.getCompilation();
        DiagnosticResult diagnosticResult = compilation.diagnosticResult();
        Assert.assertEquals(diagnosticResult.errorCount(), 9);
        CompilerPluginTestUtils.assertError101(diagnosticResult, 0, ANNOTATION_TAG_STRING, TYPE_NIL);
        CompilerPluginTestUtils.assertError101(diagnosticResult, 1, ANNOTATION_TAG_STRING, TYPE_BOOLEAN);
        CompilerPluginTestUtils.assertError101(diagnosticResult, 2, ANNOTATION_TAG_STRING, TYPE_INT);
        CompilerPluginTestUtils.assertError101(diagnosticResult, 3, ANNOTATION_TAG_STRING, TYPE_FLOAT);
        CompilerPluginTestUtils.assertError101(diagnosticResult, 4, ANNOTATION_TAG_STRING, TYPE_DECIMAL);
        CompilerPluginTestUtils.assertError101(diagnosticResult, 5, ANNOTATION_TAG_STRING, TYPE_XML);
        CompilerPluginTestUtils.assertError101(diagnosticResult, 6, ANNOTATION_TAG_STRING, TYPE_ANYDATA_ARRAY);
        CompilerPluginTestUtils.assertError101(diagnosticResult, 7, ANNOTATION_TAG_STRING, TYPE_MAP_OF_ANYDATA);
        CompilerPluginTestUtils.assertError101(diagnosticResult, 8, ANNOTATION_TAG_STRING, TYPE_TABLE_OF_ANYDATA);
    }

    @Test
    public void testArrayAnnotationTagCompatibility() {
        Package currentPackage = CompilerPluginTestUtils.loadPackage("sample_package_6");
        PackageCompilation compilation = currentPackage.getCompilation();
        DiagnosticResult diagnosticResult = compilation.diagnosticResult();
        Assert.assertEquals(diagnosticResult.errorCount(), 9);
        CompilerPluginTestUtils.assertError101(diagnosticResult, 0, ANNOTATION_TAG_ARRAY, TYPE_NIL);
        CompilerPluginTestUtils.assertError101(diagnosticResult, 1, ANNOTATION_TAG_ARRAY, TYPE_BOOLEAN);
        CompilerPluginTestUtils.assertError101(diagnosticResult, 2, ANNOTATION_TAG_ARRAY, TYPE_INT);
        CompilerPluginTestUtils.assertError101(diagnosticResult, 3, ANNOTATION_TAG_ARRAY, TYPE_FLOAT);
        CompilerPluginTestUtils.assertError101(diagnosticResult, 4, ANNOTATION_TAG_ARRAY, TYPE_DECIMAL);
        CompilerPluginTestUtils.assertError101(diagnosticResult, 5, ANNOTATION_TAG_ARRAY, TYPE_STRING);
        CompilerPluginTestUtils.assertError101(diagnosticResult, 6, ANNOTATION_TAG_ARRAY, TYPE_XML);
        CompilerPluginTestUtils.assertError101(diagnosticResult, 7, ANNOTATION_TAG_ARRAY, TYPE_MAP_OF_ANYDATA);
        CompilerPluginTestUtils.assertError101(diagnosticResult, 8, ANNOTATION_TAG_ARRAY, TYPE_TABLE_OF_ANYDATA);
    }

    @Test
    public void testAnnotationTagCompatibilityForUnionTypes() {
        Package currentPackage = CompilerPluginTestUtils.loadPackage("sample_package_7");
        PackageCompilation compilation = currentPackage.getCompilation();
        DiagnosticResult diagnosticResult = compilation.diagnosticResult();
        Assert.assertEquals(diagnosticResult.errorCount(), 6);
        CompilerPluginTestUtils.assertError101(diagnosticResult, 0, ANNOTATION_TAG_STRING, "string?");
        CompilerPluginTestUtils.assertError101(diagnosticResult, 1, ANNOTATION_TAG_NUMBER, "int?");
        CompilerPluginTestUtils.assertError101(diagnosticResult, 2, ANNOTATION_TAG_INT, "int?");
        CompilerPluginTestUtils.assertError101(diagnosticResult, 3, ANNOTATION_TAG_FLOAT, "float?");
        CompilerPluginTestUtils.assertError101(diagnosticResult, 4, ANNOTATION_TAG_NUMBER, "decimal?");
        CompilerPluginTestUtils.assertError101(diagnosticResult, 5, ANNOTATION_TAG_ARRAY, "float[]?");
    }

    @Test
    public void testIntAnnotationTagConstraintsAvailability() {
        Package currentPackage = CompilerPluginTestUtils.loadPackage("sample_package_8");
        PackageCompilation compilation = currentPackage.getCompilation();
        DiagnosticResult diagnosticResult = compilation.diagnosticResult();
        Assert.assertEquals(diagnosticResult.errorCount(), 1);
        CompilerPluginTestUtils.assertError102(diagnosticResult, 0, ANNOTATION_TAG_INT);
    }

    @Test
    public void testFloatAnnotationTagConstraintsAvailability() {
        Package currentPackage = CompilerPluginTestUtils.loadPackage("sample_package_9");
        PackageCompilation compilation = currentPackage.getCompilation();
        DiagnosticResult diagnosticResult = compilation.diagnosticResult();
        Assert.assertEquals(diagnosticResult.errorCount(), 1);
        CompilerPluginTestUtils.assertError102(diagnosticResult, 0, ANNOTATION_TAG_FLOAT);
    }

    @Test
    public void testNumberAnnotationTagConstraintsAvailability() {
        Package currentPackage = CompilerPluginTestUtils.loadPackage("sample_package_10");
        PackageCompilation compilation = currentPackage.getCompilation();
        DiagnosticResult diagnosticResult = compilation.diagnosticResult();
        Assert.assertEquals(diagnosticResult.errorCount(), 1);
        CompilerPluginTestUtils.assertError102(diagnosticResult, 0, ANNOTATION_TAG_NUMBER);
    }

    @Test
    public void testStringAnnotationTagConstraintsAvailability() {
        Package currentPackage = CompilerPluginTestUtils.loadPackage("sample_package_11");
        PackageCompilation compilation = currentPackage.getCompilation();
        DiagnosticResult diagnosticResult = compilation.diagnosticResult();
        Assert.assertEquals(diagnosticResult.errorCount(), 1);
        CompilerPluginTestUtils.assertError102(diagnosticResult, 0, ANNOTATION_TAG_STRING);
    }

    @Test
    public void testArrayAnnotationTagConstraintsAvailability() {
        Package currentPackage = CompilerPluginTestUtils.loadPackage("sample_package_12");
        PackageCompilation compilation = currentPackage.getCompilation();
        DiagnosticResult diagnosticResult = compilation.diagnosticResult();
        Assert.assertEquals(diagnosticResult.errorCount(), 1);
        CompilerPluginTestUtils.assertError102(diagnosticResult, 0, ANNOTATION_TAG_ARRAY);
    }

    @Test
    public void testIntAnnotationTagConstraintsCompatibility() {
        Package currentPackage = CompilerPluginTestUtils.loadPackage("sample_package_13");
        PackageCompilation compilation = currentPackage.getCompilation();
        DiagnosticResult diagnosticResult = compilation.diagnosticResult();
        Assert.assertEquals(diagnosticResult.errorCount(), 2);
        CompilerPluginTestUtils.assertError103(diagnosticResult, 0, ANNOTATION_TAG_INT);
        CompilerPluginTestUtils.assertError103(diagnosticResult, 1, ANNOTATION_TAG_INT);
    }

    @Test
    public void testFloatAnnotationTagConstraintsCompatibility() {
        Package currentPackage = CompilerPluginTestUtils.loadPackage("sample_package_14");
        PackageCompilation compilation = currentPackage.getCompilation();
        DiagnosticResult diagnosticResult = compilation.diagnosticResult();
        Assert.assertEquals(diagnosticResult.errorCount(), 2);
        CompilerPluginTestUtils.assertError103(diagnosticResult, 0, ANNOTATION_TAG_FLOAT);
        CompilerPluginTestUtils.assertError103(diagnosticResult, 1, ANNOTATION_TAG_FLOAT);
    }

    @Test
    public void testNumberAnnotationTagConstraintsCompatibility() {
        Package currentPackage = CompilerPluginTestUtils.loadPackage("sample_package_15");
        PackageCompilation compilation = currentPackage.getCompilation();
        DiagnosticResult diagnosticResult = compilation.diagnosticResult();
        Assert.assertEquals(diagnosticResult.errorCount(), 2);
        CompilerPluginTestUtils.assertError103(diagnosticResult, 0, ANNOTATION_TAG_NUMBER);
        CompilerPluginTestUtils.assertError103(diagnosticResult, 1, ANNOTATION_TAG_NUMBER);
    }

    @Test
    public void testStringAnnotationTagConstraintsCompatibility() {
        Package currentPackage = CompilerPluginTestUtils.loadPackage("sample_package_16");
        PackageCompilation compilation = currentPackage.getCompilation();
        DiagnosticResult diagnosticResult = compilation.diagnosticResult();
        Assert.assertEquals(diagnosticResult.errorCount(), 2);
        CompilerPluginTestUtils.assertError103(diagnosticResult, 0, ANNOTATION_TAG_STRING);
        CompilerPluginTestUtils.assertError103(diagnosticResult, 1, ANNOTATION_TAG_STRING);
    }

    @Test
    public void testArrayAnnotationTagConstraintsCompatibility() {
        Package currentPackage = CompilerPluginTestUtils.loadPackage("sample_package_17");
        PackageCompilation compilation = currentPackage.getCompilation();
        DiagnosticResult diagnosticResult = compilation.diagnosticResult();
        Assert.assertEquals(diagnosticResult.errorCount(), 2);
        CompilerPluginTestUtils.assertError103(diagnosticResult, 0, ANNOTATION_TAG_ARRAY);
        CompilerPluginTestUtils.assertError103(diagnosticResult, 1, ANNOTATION_TAG_ARRAY);
    }

    @Test
    public void testStringAnnotationTagConstraintsValidity() {
        Package currentPackage = CompilerPluginTestUtils.loadPackage("sample_package_18");
        PackageCompilation compilation = currentPackage.getCompilation();
        DiagnosticResult diagnosticResult = compilation.diagnosticResult();
        Assert.assertEquals(diagnosticResult.errorCount(), 3);
        CompilerPluginTestUtils.assertError104(diagnosticResult, 0, ANNOTATION_TAG_STRING, TYPE_STRING);
        CompilerPluginTestUtils.assertError104(diagnosticResult, 1, ANNOTATION_TAG_STRING, TYPE_STRING);
        CompilerPluginTestUtils.assertError104(diagnosticResult, 1, ANNOTATION_TAG_STRING, TYPE_STRING);
    }

    @Test
    public void testArrayAnnotationTagConstraintsValidity() {
        Package currentPackage = CompilerPluginTestUtils.loadPackage("sample_package_19");
        PackageCompilation compilation = currentPackage.getCompilation();
        DiagnosticResult diagnosticResult = compilation.diagnosticResult();
        Assert.assertEquals(diagnosticResult.errorCount(), 3);
        CompilerPluginTestUtils.assertError104(diagnosticResult, 0, ANNOTATION_TAG_ARRAY, TYPE_ANYDATA_ARRAY);
        CompilerPluginTestUtils.assertError104(diagnosticResult, 1, ANNOTATION_TAG_ARRAY, TYPE_ANYDATA_ARRAY);
        CompilerPluginTestUtils.assertError104(diagnosticResult, 1, ANNOTATION_TAG_ARRAY, TYPE_ANYDATA_ARRAY);
    }
}
