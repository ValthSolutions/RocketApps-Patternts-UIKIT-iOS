import UIKit
import Styling

open class BenefitStyle {
    var fontProfile: FontProfile?
    var textColor: ColorScheme?
    var icon: UIImage?
    var effect: Effects?
    var backgroundColor: ColorScheme?
    var spacing: Spacing?
    var topText: String?
    var bottomText: String?
    
    public init(
        topText: String? = nil,
        bottomText: String? = nil,
        icon: UIImage? = nil,
        fontProfile: FontProfile? = nil,
        backgroundColor: ColorScheme? = nil,
        textColor: ColorScheme? = nil,
        spacing: Spacing? = nil,
        effect: Effects? = nil
    ) {
        self.topText = topText
        self.bottomText = bottomText
        self.icon = icon
        self.fontProfile = fontProfile
        self.backgroundColor = backgroundColor
        self.spacing = spacing
        self.textColor = textColor
        self.effect = effect
    }
}

extension BenefitStyle {
    public static var `default`: BenefitStyle {
        return BenefitStyle(
            fontProfile: FontProfile(style: .caption1Regular),
            backgroundColor: .init(ColorScheme(light: .clear, dark: .clear)),
            textColor: .init(ColorScheme(light: .black, dark: .white))
        )
    }
}
