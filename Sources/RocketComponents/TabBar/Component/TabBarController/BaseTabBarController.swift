//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 20.09.2023.
//

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
    private var customTabBar: BaseTabBar?
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.customTabBar = BaseTabBar(frame: self.tabBar.frame)
        self.delegate = self
        self.setValue(customTabBar, forKey: "tabBar")
    }
    
    open func decorateTabBar(with style: TabBarStyle) {     customTabBar?.decorate(with: style)
    }
    
    /// Updates the state of the center button when a tab bar item is selected.
    open func tabBarController(_ tabBarController: UITabBarController,
                               didSelect viewController: UIViewController
    ) {
        customTabBar?.updateCenterButtonState()
    }
}
