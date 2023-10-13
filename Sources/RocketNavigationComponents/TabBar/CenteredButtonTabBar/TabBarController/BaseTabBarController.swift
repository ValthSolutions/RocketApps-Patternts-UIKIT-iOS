import UIKit

/// `BaseTabBarController` is an open class that provides a customizable tab bar controller with a prominent center button.
/// This controller acts as a base and can be extended for more specific use cases.
///
open class BaseTabBarController: UITabBarController,
                                 UITabBarControllerDelegate {
    
    /// Specifies the index of the center tab. It is important to set this property to get the desired behavior.
    /// Default value is 0.
    open var centerTabIndex: Int = 0 {
        didSet {
            customTabBar?.centerTabIndex = centerTabIndex
        }
    }
    
    /// Represents the custom tab bar, which includes the center button.
    open var customTabBar: BaseCenteredTabBar?
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.customTabBar = BaseCenteredTabBar(frame: self.tabBar.frame)
        self.delegate = self
        self.setValue(customTabBar, forKey: "tabBar")
    }
    
    open func decorateTabBar(with style: CenteredTabBarStyle) {
        customTabBar?.decorate(with: style)
    }
    
    /// Updates the state of the center button when a tab bar item is selected.
    open func tabBarController(_ tabBarController: UITabBarController,
                               didSelect viewController: UIViewController
    ) {
        customTabBar?.updateCenterButtonState()
    }
}
