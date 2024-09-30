import Styling
import UIKit

public struct CenteredTabBarStyle {
    
    var unselectedItemTintColor: ColorScheme?
    var tintColor: ColorScheme?
    var centerIcon: UIImage?
    var shadowEffectTabBar: Shadow?
    var shadowEffectButton: Shadow?
    var centerIconSelectionColor: (on: ColorScheme?, off: ColorScheme?)?
    
    public init(unselectedItemTintColor: ColorScheme? = nil,
                tintColor: ColorScheme? = nil,
                centerIcon: UIImage? = nil,
                centerIconSelectionColor: (on: ColorScheme?, off: ColorScheme?)? = nil,
                shadowEffectTabBar: Shadow? = nil,
                shadowEffectButton: Shadow? = nil
    ) {
        self.centerIconSelectionColor = centerIconSelectionColor
        self.unselectedItemTintColor = unselectedItemTintColor
        self.shadowEffectTabBar = shadowEffectTabBar
        self.shadowEffectButton = shadowEffectButton
        self.tintColor = tintColor
        self.centerIcon = centerIcon
    }
}

public extension CenteredTabBarStyle {
    static let `default`: CenteredTabBarStyle = CenteredTabBarStyle(
        unselectedItemTintColor: nil,
        tintColor: nil,
        centerIcon: nil,
        shadowEffectTabBar: Shadow(color:
                                    UIColor.black,
                                   offset:
                                    CGSize(width: 0,
                                           height: 2),
                                   radius: 15,
                                   opacity: 0.3),
        shadowEffectButton: Shadow(color:
                                    UIColor.black,
                                   offset:
                                    CGSize(width: 0,
                                           height: 2),
                                   radius: 15,
                                   opacity: 0.3)
    )
}
