import UIKit

public extension TypographyButtonApplicable where Self: UIButton {
    func applyTypography(fontFamily: String, style: Typography.Style, text: String, forState state: UIControl.State = .normal) {
        let profile = FontProfile(fontFamily: fontFamily, style: style)
        self.setAttributedTitle(Typography.attributedString(for: profile, text: text), for: state)
    }
}

extension UITextField: TypographyTextFieldApplicable {
    public func applyTypography(_ profile: FontProfile) {
        self.font = Typography.font(for: profile)
    }
    
    public func applyTypographyForPlaceholder(_ profile: FontProfile) {
        guard let placeholderText = self.placeholder else { return }
        let attributedPlaceholder = Typography.attributedString(for: profile, text: placeholderText)
        self.attributedPlaceholder = attributedPlaceholder
    }
}

 extension UILabel: TypographyApplicable {
     public func applyTypography(_ profile: FontProfile) {
         self.font = Typography.font(for: profile)
    }
}

extension UITextView: TypographyApplicable {
    public func applyTypography(_ profile: FontProfile) {
        self.font = Typography.font(for: profile)
    }
}
