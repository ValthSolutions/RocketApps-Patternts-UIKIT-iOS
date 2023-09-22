import UIKit

public extension TypographyButtonApplicable where Self: UIButton {
    func applyTypography(fontFamily: String, style: Typography.Style, text: String, forState state: UIControl.State = .normal) {
        let profile = FontProfile(fontFamily: fontFamily, style: style)
        self.setAttributedTitle(Typography.attributedString(for: profile, text: text), for: state)
    }
}

extension UITextField: TypographyTextFieldApplicable {
    public func applyTypography(fontFamily: String, style: Typography.Style, text: String) -> NSAttributedString  {
        let profile = FontProfile(fontFamily: fontFamily, style: style)
        return Typography.attributedString(for: profile, text: text)
    }
}

 extension UILabel: TypographyApplicable {
     public func applyTypography(fontFamily: String, style: Typography.Style, text: String) {
        let profile = FontProfile(fontFamily: fontFamily, style: style)
        self.attributedText = Typography.attributedString(for: profile, text: text)
    }
}

extension UITextView: TypographyApplicable {
    public func applyTypography(fontFamily: String, style: Typography.Style, text: String) {
        let profile = FontProfile(fontFamily: fontFamily, style: style)
        self.attributedText = Typography.attributedString(for: profile, text: text)
    }
}
