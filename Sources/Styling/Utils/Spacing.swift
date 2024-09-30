import Foundation

/// Defines standardized spacing values for consistent layout.
///
/// This enum provides a set of predefined spacing increments,
/// ensuring consistent gaps and padding across the application's UI.
///

@available(
    *, deprecated,
     message: "Replace with Space.step16 or appropriate Space constant")

public enum Spacing: RawRepresentable {
    
    public typealias RawValue = CGFloat
    
    /// Represents a spacing of 2 points.
    case step0
    
    /// Represents a spacing of 4 points.
    case step1
    
    /// Represents a spacing of 6 points.
    case step2
    
    /// Represents a spacing of 8 points.
    case step3
    
    /// Represents a spacing of 12 points.
    case step4
    
    /// Represents a spacing of 16 points.
    case step5
    
    /// Represents a spacing of 24 points.
    case step6
    
    /// Represents a spacing of 32 points.
    case step7
    
    /// Represents a spacing of 40 points.
    case step8
    
    /// Represents a spacing of 48 points.
    case step9
    
    /// Represents a spacing of 56 points.
    case step10
    
    /// Represents a spacing of 64 points.
    case step11
    
    /// Represents a spacing of 72 points.
    case step12
    
    /// Represents a spacing of 80 points.
    case step13
    
    /// Represents a spacing with custom value.
    case custom(CGFloat)
    
    public var rawValue: CGFloat {
        switch self {
        case .step0: return 2.0
        case .step1: return 4.0
        case .step2: return 6.0
        case .step3: return 8.0
        case .step4: return 12.0
        case .step5: return 16.0
        case .step6: return 24.0
        case .step7: return 32.0
        case .step8: return 40.0
        case .step9: return 48.0
        case .step10: return 56.0
        case .step11: return 64.0
        case .step12: return 72.0
        case .step13: return 80.0
        case .custom(let value): return value
        }
    }
    
    public init?(rawValue: CGFloat) {
        switch rawValue {
        case 2.0: self = .step0
        case 4.0: self = .step1
        case 6.0: self = .step2
        case 8.0: self = .step3
        case 12.0: self = .step4
        case 16.0: self = .step5
        case 24.0: self = .step6
        case 32.0: self = .step7
        case 40.0: self = .step8
        case 48.0: self = .step9
        case 56.0: self = .step10
        case 64.0: self = .step11
        case 72.0: self = .step12
        case 80.0: self = .step13
        default: self = .custom(rawValue)
        }
    }
}
