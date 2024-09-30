import UIKit

/// Represents a shadow effect with customizable parameters.
public struct Shadow {
    
    /// The color of the shadow.
    public var color: UIColor
    
    /// The offset of the shadow.
    public var offset: CGSize
    
    /// The radius of the shadow.
    public var radius: CGFloat
    
    /// The opacity of the shadow.
    public var opacity: Float
    
    /// Initializes a new Shadow object with the provided parameters.
    /// - Parameters:
    ///   - color: The color of the shadow.
    ///   - offset: The offset of the shadow.
    ///   - radius: The radius of the shadow.
    ///   - opacity: The opacity of the shadow.
    public init(color: UIColor,
                offset: CGSize,
                radius: CGFloat,
                opacity: Float
    ) {
        self.color = color
        self.offset = offset
        self.radius = radius
        self.opacity = opacity
    }
}

public extension Shadow {
    /// Represents a light shadow effect.
    static var light: Shadow {
        return Shadow(color: .black, offset: CGSize(width: 0, height: 2), radius: 6, opacity: 0.03)
    }
    
    /// Represents a medium intensity shadow effect.
    static var medium: Shadow {
        return Shadow(color: .black, offset: CGSize(width: 0, height: 5), radius: 6, opacity: 0.06)
    }
    
    /// Represents a heavy shadow effect.
    static var heavy: Shadow {
        return Shadow(color: .black, offset: CGSize(width: 0, height: 5), radius: 6, opacity: 0.12)
    }
}
