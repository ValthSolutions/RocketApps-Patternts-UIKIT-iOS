import Foundation

/// Defines standardized spacing values for consistent layout.
///
/// This enum provides a set of predefined spacing increments,
/// ensuring consistent gaps and padding across the application's UI.

public struct Space {
    /// Represents a spacing of 2 points.
    public static let step2: CGFloat = 2.0
    
    /// Represents a spacing of 4 points.
    public static let step4: CGFloat = 4.0
    
    /// Represents a spacing of 6 points.
    public static let step6: CGFloat = 6.0
    
    /// Represents a spacing of 8 points.
    public static let step8: CGFloat = 8.0
    
    /// Represents a spacing of 12 points.
    public static let step12: CGFloat = 12.0
    
    /// Represents a spacing of 14 points.
    public static let step14: CGFloat = 14.0
    
    /// Represents a spacing of 16 points.
    public static let step16: CGFloat = 16.0
    
    /// Represents a spacing of 18 points.
    public static let step18: CGFloat = 18.0
    
    /// Represents a spacing of 20 points.
    public static let step20: CGFloat = 20.0
    
    /// Represents a spacing of 24 points.
    public static let step24: CGFloat = 24.0
    
    /// Represents a spacing of 26 points.
    public static let step26: CGFloat = 26.0
    
    /// Represents a spacing of 32 points.
    public static let step32: CGFloat = 32.0
    
    /// Represents a spacing of 40 points.
    public static let step40: CGFloat = 40.0
    
    /// Represents a spacing of 42 points.
    public static let step42: CGFloat = 42.0
    
    /// Represents a spacing of 48 points.
    public static let step48: CGFloat = 48.0
    
    /// Represents a spacing of 56 points.
    public static let step56: CGFloat = 56.0
    
    /// Represents a spacing of 64 points.
    public static let step64: CGFloat = 64.0
    
    /// Represents a spacing of 72 points.
    public static let step72: CGFloat = 72.0
    
    /// Represents a spacing of 80 points.
    public static let step80: CGFloat = 80.0
    
    /// Represents a spacing with custom value.
    public static func custom(_ value: CGFloat) -> CGFloat {
        return value
    }
    
    /// Represents a spacing with custom value.
    public static func custom(_ value: Int) -> CGFloat {
        return CGFloat(value)
    }
}
