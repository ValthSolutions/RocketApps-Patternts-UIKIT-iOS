public enum ValidationResult<E> {
    case success
    case failure(E)
    
    public var isValid: Bool {
        switch self {
        case .success:
            return true
        case .failure:
            return false
        }
    }
}
