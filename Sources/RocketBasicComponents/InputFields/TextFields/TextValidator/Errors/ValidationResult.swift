//public enum ValidationResult<E> {
//    case success
//    case failure(E)
//
//    public var isValid: Bool {
//        switch self {
//        case .success:
//            return true
//        case .failure:
//            return false
//        }
//    }
//}

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

public enum ValidationError: Error {
    case emptyValue
    // MARK: - ErrorDescription
    
    public var description: String {
        switch self {
        case .emptyValue:
            return "emptyValue"
        }
    }
}
