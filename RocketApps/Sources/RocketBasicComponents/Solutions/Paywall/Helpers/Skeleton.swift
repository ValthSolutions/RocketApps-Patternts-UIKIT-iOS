import UIKit
import Styling

open class Skeleton {
    
    // MARK: - Button Styles
    struct ButtonStyles {
        static var tryFreeStyle: (String, ButtonStyle) {
            return ("Try free & Subscribe",
                    ButtonStyle(
                        type: .primary(
                            defaultColor: ColorScheme(light: UIColor(red: 0.071, green: 0.717, blue: 0.416, alpha: 1),
                                                      dark: UIColor(red: 0.071, green: 0.717, blue: 0.416, alpha: 1))
                        ),
                        fontProfile: FontProfile(style: .body1Regular),
                        effect:
                            Effects(cornerRadius: 12,
                                    hapticFeedback: .light,
                                    transformEffect: CGAffineTransform(scaleX: 0.95, y: 0.95)
                                   ),
                        textColor: ColorScheme(light: .white, dark: .white)
                    ))
        }
        
        static var chooseStyle: (String, ButtonStyle) {
            return ("Choose",
                    ButtonStyle(
                        type: .primary(
                            defaultColor: ColorScheme(light: UIColor(red: 0.071, green: 0.717, blue: 0.416, alpha: 1),
                                                      dark: UIColor(red: 0.071, green: 0.717, blue: 0.416, alpha: 1))
                        ),
                        fontProfile: FontProfile(style: .body1Regular),
                        effect:
                            Effects(cornerRadius: 12,
                                    hapticFeedback: .light,
                                    transformEffect: CGAffineTransform(scaleX: 0.95, y: 0.95)
                                   ),
                        textColor: ColorScheme(light: .white, dark: .white)
                    ))
        }
        
        
        static var close: ButtonStyle {
            return ButtonStyle(
                type: .primary(
                    defaultColor: ColorScheme(light: UIColor(red: 1, green: 1, blue: 1, alpha: 0.9),
                                              dark: UIColor(red: 1, green: 1, blue: 1, alpha: 0.9))
                ),
                icon: UIImage(named: "x", in: StylingResource.bundle, compatibleWith: .current),
                effect: Effects(rounded: true)
            )
        }
        
        static var viewAllPlans: (String, ButtonStyle) {
            return ("View all plans",
                    ButtonStyle(
                        type: .primary(
                            defaultColor: ColorScheme(light: .clear,
                                                      dark: .clear)
                        ),
                        fontProfile: FontProfile(style: .body2Semibold),
                        icon: UIImage(named: "right.arrow", in: StylingResource.bundle, with: .none),
                        iconPosition: .right,
                        spacing: .step4,
                        textColor: ColorScheme(light: .black, dark: .black)
                    ))
        }
    }
    
    // MARK: - Label Styles
    struct LabelStyles {
        static var autoRenewable: (String, LabelStyle)  {
            return ("Auto-renewable. Cancel anytime",
                    LabelStyle(
                        fontProfile: FontProfile(style: .caption1Regular),
                        textColor: .init(ColorScheme(light: .black, dark: .black))))
        }
        
        static var chooseThePlan: (String, LabelStyle)  {
            return ("Choose the plan",
                    LabelStyle(
                        fontProfile: FontProfile(style: .largeTitle),
                        textColor: .init(ColorScheme(light: .black, dark: .black))))
        }
    }
    
    struct SubscriptionStyles {
        static var radioWithout: SubscriptionStyle {
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
                            cornerRadius: 12),
            withRadioButton: false,
            radioButtonStyle: .init()
        )
        }
    }
}
