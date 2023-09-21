import UIKit

#warning("TODO - for more flexibility, I would say it's better to use protocol here to be able to overload function if needed")
public extension UILabel {
    func applyTypography(fontFamily: String, style: Typography.Style, text: String) {
        let profile = FontProfile(fontFamily: fontFamily, style: style)
        self.attributedText = Typography.attributedString(for: profile, text: text)
    }
}

public extension UIButton {
    func applyTypography(fontFamily: String, style: Typography.Style, text: String, forState state: UIControl.State = .normal) {
        let profile = FontProfile(fontFamily: fontFamily, style: style)
        self.setAttributedTitle(Typography.attributedString(for: profile, text: text), for: state)
    }
}

public extension UITextField {
    func applyTypography(fontFamily: String, style: Typography.Style, text: String) {
        let profile = FontProfile(fontFamily: fontFamily, style: style)
        self.attributedText = Typography.attributedString(for: profile, text: text)
    }
}

public extension UITextView {
    func applyTypography(fontFamily: String, style: Typography.Style, text: String) {
        let profile = FontProfile(fontFamily: fontFamily, style: style)
        self.attributedText = Typography.attributedString(for: profile, text: text)
    }
}
