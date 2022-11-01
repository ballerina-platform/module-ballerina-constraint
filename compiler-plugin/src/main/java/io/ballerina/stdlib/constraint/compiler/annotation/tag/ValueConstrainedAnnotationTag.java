package io.ballerina.stdlib.constraint.compiler.annotation.tag;

import java.util.ArrayList;

import static io.ballerina.stdlib.constraint.compiler.Constants.CONSTRAINT_MAX_VALUE;
import static io.ballerina.stdlib.constraint.compiler.Constants.CONSTRAINT_MAX_VALUE_EXCLUSIVE;
import static io.ballerina.stdlib.constraint.compiler.Constants.CONSTRAINT_MIN_VALUE;
import static io.ballerina.stdlib.constraint.compiler.Constants.CONSTRAINT_MIN_VALUE_EXCLUSIVE;

/**
 * The interface to represent the value constraints of the annotation tags.
 */
public interface ValueConstrainedAnnotationTag extends AnnotationTag {

    @Override
    default boolean haveCompatibleConstraints(ArrayList<String> constraints) {
        return !(constraints.contains(CONSTRAINT_MIN_VALUE) && constraints.contains(CONSTRAINT_MIN_VALUE_EXCLUSIVE) ||
                constraints.contains(CONSTRAINT_MAX_VALUE) && constraints.contains(CONSTRAINT_MAX_VALUE_EXCLUSIVE));
    }
}
