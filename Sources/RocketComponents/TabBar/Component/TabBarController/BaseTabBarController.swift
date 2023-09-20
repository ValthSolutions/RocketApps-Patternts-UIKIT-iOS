//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 20.09.2023.
//

import UIKit

open class BaseTabBarController: UITabBarController,
                                 UITabBarControllerDelegate {
    
    open var centerTabIndex: Int = 0 {
        didSet {
            customTabBar?.centerTabIndex = centerTabIndex
        }
    }
    
    private var customTabBar: BaseTabBar?
    private let style: TabBarStyle
    
    init(style: TabBarStyle) {
        self.style = style
        super.init()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.customTabBar = BaseTabBar(frame: self.tabBar.frame)
        self.delegate = self
        self.setValue(customTabBar, forKey: "tabBar")
        customTabBar?.decorate(with: style)
    }
    
    open func tabBarController(_ tabBarController: UITabBarController,
                               didSelect viewController: UIViewController
    ) {
        customTabBar?.updateCenterButtonState()
    }
}
