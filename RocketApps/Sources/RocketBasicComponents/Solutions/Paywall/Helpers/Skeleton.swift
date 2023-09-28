import UIKit
import Styling

open class Skeleton {
    
    // MARK: - Button Styles
    struct ButtonStyles {
        static var primary: (String, ButtonStyle) {
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
    }
}
