package io.ballerina.stdlib.constraint;

/**
 * Exceptions that could occur in Constraint native level.
 */
public class InternalValidationException extends RuntimeException {

    public InternalValidationException(String message) {
        super(message);
    }
}
