import UIKit

public struct FontProfile {
    public let fontFamily: String
    public let style: Typography.Style
    
    public init(fontFamily: String = Typography.defaultFontFamily,
                style: Typography.Style) {
        self.fontFamily = fontFamily
        self.style = style
    }
}

public struct TypographyAttributes {
    var fontSize: CGFloat
    var fontWeight: UIFont.Weight
    var lineHeight: CGFloat
    var letterSpacing: CGFloat
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
        /// Custom TypographyAttributes
        case custom(TypographyAttributes)
        
        
        var attributes: TypographyAttributes {
            switch self {
            case .largeTitle:
                return TypographyAttributes(fontSize: 34, fontWeight: .bold, lineHeight: 41, letterSpacing: -0.4)
            case .title1Bold:
                return TypographyAttributes(fontSize: 28, fontWeight: .bold, lineHeight: 34, letterSpacing: -0.4)
            case .title2Bold:
                return TypographyAttributes(fontSize: 22, fontWeight: .bold, lineHeight: 28, letterSpacing: -0.4)
            case .title3Bold:
                return TypographyAttributes(fontSize: 20, fontWeight: .bold, lineHeight: 25, letterSpacing: -0.4)
            case .title3Semibold:
                return TypographyAttributes(fontSize: 20, fontWeight: .semibold, lineHeight: 25, letterSpacing: -0.4)
            case .title3Regular:
                return TypographyAttributes(fontSize: 20, fontWeight: .regular, lineHeight: 25, letterSpacing: -0.4)
            case .body1Semibold:
                return TypographyAttributes(fontSize: 17, fontWeight: .semibold, lineHeight: 22, letterSpacing: -0.4)
            case .body1Medium:
                return TypographyAttributes(fontSize: 17, fontWeight: .medium, lineHeight: 22, letterSpacing: -0.4)
            case .body1Regular:
                return TypographyAttributes(fontSize: 17, fontWeight: .regular, lineHeight: 22, letterSpacing: -0.4)
            case .body2Semibold:
                return TypographyAttributes(fontSize: 15, fontWeight: .semibold, lineHeight: 20, letterSpacing: -0.4)
            case .body2Regular:
                return TypographyAttributes(fontSize: 15, fontWeight: .regular, lineHeight: 20, letterSpacing: -0.4)
            case .caption1Regular:
                return TypographyAttributes(fontSize: 13, fontWeight: .regular, lineHeight: 18, letterSpacing: -0.4)
            case .caption1Semibold:
                return TypographyAttributes(fontSize: 11, fontWeight: .semibold, lineHeight: 13, letterSpacing: -0.4)
            case .caption3Regular:
                return TypographyAttributes(fontSize: 10, fontWeight: .regular, lineHeight: 12, letterSpacing: -0.4)
            case .custom(let customAttributes):
                return customAttributes
            }
        }
    }
}
