import UIKit
import Styling

open class BenefitStyle {
    var icon: UIImage?
    var effect: Effects?
    var topText: String?
    var bottomText: String?
    var topLabelStyle: LabelStyle?
    var bottomLabelStyle: LabelStyle?
    
    public init(
        topText: String? = nil,
        bottomText: String? = nil,
        icon: UIImage? = nil,
        effect: Effects? = nil,
        topLabelStyle: LabelStyle? = nil,
        bottomLabelStyle: LabelStyle? = nil
    ) {
        self.topText = topText
        self.bottomText = bottomText
        self.icon = icon
        self.bottomLabelStyle = bottomLabelStyle
        self.topLabelStyle = topLabelStyle
        self.effect = effect
    }
}

extension BenefitStyle {
    public static var `default`: BenefitStyle {
        return BenefitStyle(
            topText: "Unlock the full Floro experience",
            bottomText: "With full access",
            icon: UIImage(named: "lock.open", in: StylingResource.bundle, with: .none),
            effect: Effects(shadow: Shadow(color: UIColor(red: 0, green: 0, blue: 0, alpha: 0.08),
                                           offset: CGSize(width: 0, height: 0),
                                           radius: 20,
                                           opacity: 1.0),
                            cornerRadius: 12),
            topLabelStyle: LabelStyle(fontProfile: FontProfile(style: .body1Regular),
                                      textColor: ColorScheme(light: .black)),
            bottomLabelStyle: LabelStyle(fontProfile: FontProfile(style: .caption1Regular),
                                         textColor: ColorScheme(light: UIColor(red: 0.416, green: 0.424, blue: 0.455, alpha: 1)))
        )
    }
}
