//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 19.09.2023.
//

import Styling

/// A struct representing the styling attributes for a UIPageControl.
public struct PageControlStyle {
    
    /// The tint color to be used for the currently active page indicator.
    /// Utilizes the `ColorScheme` for light and dark mode adaptation.
    var currentPageIndicatorTintColor: ColorScheme?
    
    /// The tint color to be used for page indicators that are not currently active.
    /// Utilizes the `ColorScheme` for light and dark mode adaptation.
    var pageIndicatorTintColor: ColorScheme?
    
    /// Initializes a new `PageControlStyle` with the provided styling attributes.
    ///
    /// - Parameters:
    ///   - currentPageIndicatorTintColor: The tint color for the active page indicator.
    ///   - pageIndicatorTintColor: The tint color for inactive page indicators.
    public init(currentPageIndicatorTintColor: ColorScheme? = nil,
                pageIndicatorTintColor: ColorScheme? = nil) {
        self.currentPageIndicatorTintColor = currentPageIndicatorTintColor
        self.pageIndicatorTintColor = pageIndicatorTintColor
    }
}
