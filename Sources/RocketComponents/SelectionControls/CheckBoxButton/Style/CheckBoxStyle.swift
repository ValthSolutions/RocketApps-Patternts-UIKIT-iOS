//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 21.09.2023.
//

import Foundation

/// `CheckBoxStyle` defines the appearance of a radio button.
/// It encompasses attributes like effects, colors for different states, and proportion for sizing.
open class CheckBoxStyle {
    
    /// Affects the overall appearance such as shadows. Can be `nil` if no effects are desired.
    var effect: Effects?
    
    /// The color to use when the radio button is in a selected state.
    var selectedColor: ColorScheme?
    
    /// The color to use when the radio button is in an unselected state.
    var unselectedColor: ColorScheme?
    
    /// Proportional sizing factor for the radio button, which affects the internal padding and external line width.
    /// If `nil`, a default value is used.
    var proportion: CGFloat?
    
    /// Initializes a new instance of `CheckBoxStyle`.
    ///
    /// - Parameters:
    ///   - selectedColor: Color scheme to use when the button is selected. Default is `.cyan`.
    ///   - unselectedColor: Color scheme to use when the button is unselected. Default is `.lightGray`.
    ///   - proportion: Proportional sizing factor. Can be `nil`.
    ///   - effect: Additional visual effects like shadows. Can be `nil`.
    public init(
        selectedColor: ColorScheme? = ColorConstants.defaultSelectedColor,
        unselectedColor: ColorScheme? = ColorConstants.defaultUnselectedColor,
        proportion: CGFloat? = nil,
        effect: Effects? = Effects(cornerRadius: 4)
    ) {
        self.unselectedColor = unselectedColor
        self.selectedColor = selectedColor
        self.proportion = proportion
        self.effect = effect
    }
}
