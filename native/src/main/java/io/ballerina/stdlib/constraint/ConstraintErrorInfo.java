package io.ballerina.stdlib.constraint;

import java.util.List;
import java.util.stream.Collectors;

import static io.ballerina.stdlib.constraint.Constants.SYMBOL_SEPARATOR;
import static io.ballerina.stdlib.constraint.ErrorUtils.buildDefaultErrorMessage;

/**
 * Represents a constraint violation error information.
 */
public class ConstraintErrorInfo {
    final String path;
    final String message;
    final List<String> failedConstraints;
    final boolean onMemberType;

    public ConstraintErrorInfo(String path, String message, List<String> failedConstraints) {
        this.path = path;
        this.message = message;
        this.failedConstraints = failedConstraints;
        this.onMemberType = false;
    }

    public ConstraintErrorInfo(String path, String message, List<String> failedConstraints, boolean onMemberType) {
        this.path = path;
        this.message = message;
        this.failedConstraints = failedConstraints;
        this.onMemberType = onMemberType;
    }

    public String getPath() {
        return path;
    }

    public String getMessage() {
        return message;
    }

    public boolean hasMessage() {
        return !onMemberType && message != null;
    }

    public String getErrorMessage() {
        return message != null ? message : buildDefaultErrorMessage(failedConstraints);
    }

    public List<String> getFailedConstraintsWithPath() {
        return failedConstraints.stream().map(
                failedConstraint -> path + SYMBOL_SEPARATOR + failedConstraint).collect(Collectors.toList());
    }
}
