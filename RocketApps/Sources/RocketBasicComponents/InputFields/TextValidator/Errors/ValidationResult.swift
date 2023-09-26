public enum ValidationResult {
    case success
    case failure(ValidationError)
    
    public var isValid: Bool {
        switch self {
        case .success:
            return true
        case .failure:
            return false
        }
    }
}

public protocol ValidationError: Error {
    var description: String { get }
}
