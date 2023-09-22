import Foundation

public enum ValidationType {
    case AND
    case OR
}

public class ValidationChain {
    
    private let validators: [Validator]
    private let validationType: ValidationType
    private let validationError: ValidationError
    
    public init(validators: [Validator],
                validationType: ValidationType = .AND,
                validationError: ValidationError = .emptyValue) {
        self.validators = validators
        self.validationType = validationType
        self.validationError = validationError
    }
    
    public func validate(_ value: String) -> ValidationResult {
        switch validationType {
            
        case .AND:
            return validateAND(value)
        case .OR:
            return validateOR(value)
        }
    }
    
    public func validateAND(_ value: String) -> ValidationResult {
        for validator in validators {
            if case let .failure(error) = validator.validate(value: value) {
                return .failure(error)
            }
        }
        return .success
    }
    
    public func validateOR(_ value: String) -> ValidationResult {
        for validator in validators {
            switch validator.validate(value: value) {
                
            case .success:
                return .success
            case .failure:
                break
            }
        }
        return .failure(validationError)
    }
}
