//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 19.09.2023.
//

import UIKit

open class BasePageControl: UIPageControl, Decoratable {
    
    public typealias Style = PageControlStyle
    
    open func decorate(with style: Style) {
        if let currentPageIndicatorTintColor = style.currentPageIndicatorTintColor {
            self.currentPageIndicatorTintColor = currentPageIndicatorTintColor.color
        }
        
        if let pageIndicatorTintColor = style.pageIndicatorTintColor {
            self.pageIndicatorTintColor = pageIndicatorTintColor.color
        }
    }
}
