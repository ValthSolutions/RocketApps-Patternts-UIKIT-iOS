import UIKit

public struct ColorScheme: Equatable {
    public var light: UIColor
    public var dark: UIColor
    
    public init(light: UIColor = .clear, dark: UIColor = .clear) {
        self.light = light
        self.dark = dark
    }
    
    ///The color that mathed current user's interface mode Day/Night
    public var color: UIColor {
        return UIColor { traitCollection in
            switch traitCollection.userInterfaceStyle {
            case .dark:
                return self.dark
            default:
                return self.light
            }
        }
    }
}
