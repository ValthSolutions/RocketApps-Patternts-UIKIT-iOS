public struct Validator {
    public typealias ErrorType = ValidationErrorConvertible

    private let closure: (String) -> ValidationResult<ErrorType>
    
    public init(validation: @escaping (String) -> ValidationResult<ErrorType>) {
        self.closure = validation
    }
    
    public func validate(value: String) -> ValidationResult<ErrorType> {
        return closure(value)
    }
}
