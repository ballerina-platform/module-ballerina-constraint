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

package io.ballerina.stdlib.constraint.compiler.annotation.tag;

import io.ballerina.compiler.api.symbols.Symbol;
import io.ballerina.compiler.api.symbols.TypeDefinitionSymbol;
import io.ballerina.compiler.api.symbols.TypeSymbol;
import io.ballerina.projects.plugins.SyntaxNodeAnalysisContext;

import java.util.ArrayList;
import java.util.Map;
import java.util.Optional;

import static io.ballerina.stdlib.constraint.compiler.Constants.EMPTY;
import static io.ballerina.stdlib.constraint.compiler.Constants.MODULE_NAME;
import static io.ballerina.stdlib.constraint.compiler.Constants.PACKAGE_NAME;
import static io.ballerina.stdlib.constraint.compiler.Constants.TYPE_DATE_RECORD;

/**
 * The class to represent the `@constraint:Date` annotation tag.
 */
public class AnnotationTagDate implements AnnotationTag {

    @Override
    public boolean isCompatibleFieldType(SyntaxNodeAnalysisContext ctx, TypeSymbol fieldTypeSymbol) {
        Optional<Map<String, Symbol>> typesMap = ctx.semanticModel().types().typesInModule(
                PACKAGE_NAME, MODULE_NAME, EMPTY);
        if (typesMap.isPresent()) {
            Map<String, Symbol> moduleTypes = typesMap.get();
            Symbol dateSymbol = moduleTypes.get(TYPE_DATE_RECORD);
            return dateSymbol instanceof TypeDefinitionSymbol &&
                    fieldTypeSymbol.subtypeOf(((TypeDefinitionSymbol) dateSymbol).typeDescriptor());
        }
        return false;
    }

    @Override
    public boolean haveCompatibleConstraints(ArrayList<String> constraints) {
        // For now this will return true, since we don't have to do any additional validations
        // using the compiler plugin.
        return true;
    }
}
