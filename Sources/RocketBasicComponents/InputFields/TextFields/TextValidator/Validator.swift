public struct Validator {

    private let closure: (String) -> ValidationResult
    
    public init(validation: @escaping (String) -> ValidationResult) {
        self.closure = validation
    }
    
    public func validate(value: String) -> ValidationResult {
        return closure(value)
    }
}

extension Validator {
    static var notEmpty: Validator {
        return Validator { value in
            return !value.isEmpty ? .success : .failure(ValidationError.emptyValue)
        }
    }
}
