import UIKit

public struct FontProfile {
    public let fontFamily: String
    public let style: Typography.Style
    
    public init(fontFamily: String = Typography.defaultFontFamily, style: Typography.Style) {
        self.fontFamily = fontFamily
        self.style = style
    }
}

public struct Typography {
    
    public static var defaultFontFamily = "HelveticaNeue"
    
    public static func font(for profile: FontProfile) -> UIFont {
        let attributes = profile.style.attributes
        if let customFont = UIFont(name: profile.fontFamily, size: attributes.fontSize) {
            return customFont
        } else {
            return UIFont.systemFont(ofSize: attributes.fontSize, weight: attributes.fontWeight)
        }
    }
    
    public static func attributedString(for profile: FontProfile, text: String) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        
        return NSAttributedString(
            string: text,
            attributes: [
                .font: font(for: profile),
                .paragraphStyle: paragraphStyle
            ]
        )
    }
}

/// Extends the `Typography` structure to define a variety of text styles.
///
/// These styles represent a collection of font attributes including size,
/// weight, line height, and letter spacing. They can be utilized throughout
/// an application to maintain consistent typography and make sure text
/// remains readable and visually appealing.
extension Typography {
    
    /// Represents distinct typographic styles.
    ///
    /// Each style defines attributes related to font size, weight, line height,
    /// and letter spacing, providing a means to apply consistent typography throughout
    /// an application.
    public enum Style {
        /// Font Size: 34px
        case largeTitle
        /// Font Size: 28px
        case title1Bold
        /// Font Size: 22px
        case title2Bold
        /// Font Size: 20px
        case title3Bold
        /// Font Size: 20px
        case title3Semibold
        /// Font Size: 20px
        case title3Regular
        /// Font Size: 17px
        case body1Semibold
        /// Font Size: 17px
        case body1Medium
        /// Font Size: 17px
        case body1Regular
        /// Font Size: 15px
        case body2Semibold
        /// Font Size: 15px
        case body2Regular
        /// Font Size: 13px
        case caption1Regular
        /// Font Size: 11px
        case caption1Semibold
        /// Font Size: 10px
        case caption3Regular
        
        #warning("TODO, probably add custom as well for flexibility AND attributes should be wrapped in some structure, not cartage")
        var attributes: (fontSize: CGFloat, fontWeight: UIFont.Weight, lineHeight: CGFloat, letterSpacing: CGFloat) {
            switch self {
            case .largeTitle:
                return (34, .bold, 41, -0.4)
            case .title1Bold:
                return (28, .bold, 34, -0.4)
            case .title2Bold:
                return (22, .bold, 28, -0.4)
            case .title3Bold:
                return (20, .bold, 25, -0.4)
            case .title3Semibold:
                return (20, .semibold, 25, -0.4)
            case .title3Regular:
                return (20, .regular, 25, -0.4)
            case .body1Semibold:
                return (17, .semibold, 22, -0.4)
            case .body1Medium:
                return (17, .medium, 22, -0.4)
            case .body1Regular:
                return (17, .regular, 22, -0.4)
            case .body2Semibold:
                return (15, .semibold, 20, -0.4)
            case .body2Regular:
                return (15, .regular, 20, -0.4)
            case .caption1Regular:
                return (13, .regular, 18, -0.4)
            case .caption1Semibold:
                return (11, .semibold, 13, -0.4)
            case .caption3Regular:
                return (10, .regular, 12, -0.4)
            }
        }
    }
}
