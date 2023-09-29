import Styling
import UIKit

open class SubscriptionStyle {
    var effect: Effects?
    var topLabelStyle: LabelStyle?
    var bottomLabelStyle: LabelStyle?
    var priceLabelStyle: LabelStyle?
    
    public init(
        topLabelStyle: LabelStyle? = nil,
        priceLabelStyle: LabelStyle? = nil,
        bottomLabelStyle: LabelStyle? = nil,
        effect: Effects? = nil
    ) {
        self.bottomLabelStyle = bottomLabelStyle
        self.priceLabelStyle = priceLabelStyle
        self.topLabelStyle = topLabelStyle
        self.effect = effect
    }
}

extension SubscriptionStyle {
    public static var `default`: SubscriptionStyle {
        return SubscriptionStyle(
            topLabelStyle: LabelStyle(fontProfile: FontProfile(style: .title3Semibold),
                                      textColor: ColorScheme(light: .black, dark: .black)),
            priceLabelStyle: LabelStyle(fontProfile: FontProfile(style: .title3Semibold),
                                        textColor: ColorScheme(light: .black, dark: .black)),
            bottomLabelStyle: LabelStyle(fontProfile: FontProfile(style: .caption1Regular),
                                         textColor: ColorScheme(light: UIColor(red: 0.416, green: 0.424, blue: 0.455, alpha: 1),
                                                                dark: UIColor(red: 0.416, green: 0.424, blue: 0.455, alpha: 1))),
            effect: Effects(shadow: Shadow(color: UIColor(red: 0, green: 0, blue: 0, alpha: 0.08),
                                           offset: CGSize(width: 0, height: 0),
                                           radius: 20,
                                           opacity: 1.0),
                            cornerRadius: 12)
        )
    }
}
