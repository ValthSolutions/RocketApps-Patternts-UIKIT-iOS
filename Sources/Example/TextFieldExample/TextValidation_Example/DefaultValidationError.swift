import RocketComponents

// Create an error to feed it to a Validator later.
public struct DefaultValidationError: ValidationError {
    private let errorDescription: String

    public init(_ description: String) {
        self.errorDescription = description
    }

    public var description: String {
        return errorDescription
    }

    static var emptyValue: DefaultValidationError = DefaultValidationError("Field cannot be empty")
    // Add another error cases
}
