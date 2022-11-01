package io.ballerina.stdlib.constraint.compiler.annotation.tag;

import java.util.ArrayList;

import static io.ballerina.stdlib.constraint.compiler.Constants.CONSTRAINT_LENGTH;
import static io.ballerina.stdlib.constraint.compiler.Constants.CONSTRAINT_MAX_LENGTH;
import static io.ballerina.stdlib.constraint.compiler.Constants.CONSTRAINT_MIN_LENGTH;

/**
 * The interface to represent the length constraints of the annotation tags.
 */
public interface LengthConstrainedAnnotationTag extends AnnotationTag {

    @Override
    default boolean haveCompatibleConstraints(ArrayList<String> constraints) {
        return !(constraints.contains(CONSTRAINT_LENGTH) && constraints.contains(CONSTRAINT_MIN_LENGTH) ||
                constraints.contains(CONSTRAINT_LENGTH) && constraints.contains(CONSTRAINT_MAX_LENGTH));
    }

    default boolean isValidConstraintValue(String constraintField, String constraintValue) {
        return !CONSTRAINT_LENGTH.equals(constraintField) && !CONSTRAINT_MIN_LENGTH.equals(constraintField) &&
                !CONSTRAINT_MAX_LENGTH.equals(constraintField) || Double.parseDouble(constraintValue) > 0;
    }
}
