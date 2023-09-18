import UIKit

struct FontProfile {
    let fontFamily: String
    let style: Typography.Style

    init(fontFamily: String = Typography.defaultFontFamily, style: Typography.Style) {
        self.fontFamily = fontFamily
        self.style = style
    }
}

public struct Typography {
    
    static var defaultFontFamily = "HelveticaNeue"

    static func font(for profile: FontProfile) -> UIFont {
        let attributes = profile.style.attributes
        if let customFont = UIFont(name: profile.fontFamily, size: attributes.fontSize) {
            return customFont
        } else {
            return UIFont.systemFont(ofSize: attributes.fontSize, weight: attributes.fontWeight)
        }
    }

    static func attributedString(for profile: FontProfile, text: String) -> NSAttributedString {
        let attributes = profile.style.attributes
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = attributes.lineHeight / attributes.fontSize

        return NSAttributedString(
            string: text,
            attributes: [
                .font: font(for: profile),
                .kern: attributes.letterSpacing,
                .paragraphStyle: paragraphStyle
            ]
        )
    }
}

extension Typography {
    public enum Style {
        case largeTitle
        case title1Bold
        case title2Bold
        case title3Bold
        case title3Semibold
        case title3Regular
        case body1Semibold
        case body1Medium
        case body1Regular
        case body2Semibold
        case body2Regular
        case caption1Regular
        case caption1Semibold
        case caption3Regular

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
