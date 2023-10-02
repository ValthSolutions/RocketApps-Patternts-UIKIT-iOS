import Styling
import Foundation

/// A struct representing the styling attributes for a UIPageControl.
open class PageControlStyle {
    
    /// The tint color to be used for the currently active page indicator.
    var currentPageIndicatorTintColor: ColorScheme?
    
    /// The tint color to be used for page indicators that are not currently active.
    var pageIndicatorTintColor: ColorScheme?
    
    /// Padding between Circle around the selected Dot.
    var padding: CGFloat = 1.5
    
    /// Spacing between Dots.
    var spacing: CGFloat = 10
    
    /// The size of the Dot.
    var dotSize: CGFloat = 7
    
    /// The width of the Circle around the selected Dot.
    var strokeWidth: CGFloat = 1.0
    
    /// Determines if a circle should be drawn around the selected dot.
    var withCircle: Bool = true
    
    
    /// Initializes a new `PageControlStyle` with the provided styling attributes.
    ///
    /// - Parameters:
    ///   - currentPageIndicatorTintColor: The tint color for the currently active page indicator.
    ///                                    Utilizes the `ColorScheme` for light and dark mode adaptation.
    ///   - pageIndicatorTintColor: The tint color for page indicators that are not currently active.
    ///                             Utilizes the `ColorScheme` for light and dark mode adaptation.
    ///   - withCircle: Determines if a circle should be drawn around the selected dot.
    ///   - padding: The space between the selected dot and its surrounding circle.
    ///              This parameter only takes effect when `withCircle` is true.
    ///   - spacing: The space between consecutive dots in the page control.
    ///   - dotSize: The diameter of each dot in the page control.
    ///   - strokeWidth: The width of the circle around the selected dot.
    ///                  This parameter only takes effect when `withCircle` is true.
    
    public init(currentPageIndicatorTintColor: ColorScheme? = nil,
                pageIndicatorTintColor: ColorScheme? = nil,
                withCircle: Bool = true,
                padding: CGFloat = 1.5,
                spacing: CGFloat = 10,
                dotSize: CGFloat = 7,
                strokeWidth: CGFloat = 1.0) {
        self.currentPageIndicatorTintColor = currentPageIndicatorTintColor
        self.pageIndicatorTintColor = pageIndicatorTintColor
        self.withCircle = withCircle
        self.padding = padding
        self.spacing = spacing
        self.dotSize = dotSize
        self.strokeWidth = strokeWidth
    }
}
