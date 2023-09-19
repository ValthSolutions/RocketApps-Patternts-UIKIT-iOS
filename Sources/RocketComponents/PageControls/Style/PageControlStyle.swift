//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 19.09.2023.
//

import Styling

public struct PageControlStyle {
    
    var currentPageIndicatorTintColor: ColorScheme?
    var pageIndicatorTintColor: ColorScheme?
    
    public init(currentPageIndicatorTintColor: ColorScheme? = nil,
                pageIndicatorTintColor: ColorScheme? = nil) {
        self.currentPageIndicatorTintColor = currentPageIndicatorTintColor
        self.pageIndicatorTintColor = pageIndicatorTintColor
    }
}
