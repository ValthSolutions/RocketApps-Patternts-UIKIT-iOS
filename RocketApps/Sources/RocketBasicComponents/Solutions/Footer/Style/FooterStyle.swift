import UIKit
import Styling

/// A struct representing the styling attributes for a RegistrationFooterView.
open class FooterStyle {
    let termsOfUseText: String?
    let privacyPolicyText: String?
    let restorePurchaseText: String?
    let termsLabelStyle: LabelStyle?
    let privacyPolicyLabelStyle: LabelStyle?
    let restorePurchaseButtonStyle: ButtonStyle?
    
    public init(termsOfUseText: String? = "Terms of Use",
                privacyPolicyText: String? = "Privacy Policy",
                restorePurchaseText: String? = "Restore purchas",
                termsLabelStyle: LabelStyle? = .default,
                privacyPolicyLabelStyle: LabelStyle? = .default,
                restorePurchaseButtonStyle: ButtonStyle? = .default
    ) {
        self.privacyPolicyText = privacyPolicyText
        self.restorePurchaseText = restorePurchaseText
        self.termsOfUseText = termsOfUseText
        self.termsLabelStyle = termsLabelStyle
        self.privacyPolicyLabelStyle = privacyPolicyLabelStyle
        self.restorePurchaseButtonStyle = restorePurchaseButtonStyle
    }
}
