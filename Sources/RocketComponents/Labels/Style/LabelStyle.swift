//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 19.09.2023.
//

import UIKit
import Styling

/// A struct representing the styling attributes for a UILabel.
open class LabelStyle {
    
    /// Font-related attributes for the label.
    /// Provides information about font family, style, and weight.
    var fontProfile: FontProfile?
    
    /// The color of the text displayed in the label.
    /// Utilizes the `ColorScheme` for light and dark mode adaptation.
    var textColor: ColorScheme?
    
    /// Effects such as shadow, corner radius, blur, etc., that are applied to the label.
    var effect: Effects?
    
    /// The background color for the label.
    /// Utilizes the `ColorScheme` for light and dark mode adaptation.
    var backgroundColor: ColorScheme?
    
    /// Initializes a new `LabelStyle` with the provided styling attributes.
    ///
    /// - Parameters:
    ///   - fontProfile: The font attributes for the label.
    ///   - backgroundColor: The background color of the label.
    ///   - textColor: The color of the text in the label.
    ///   - effect: Any visual effects to apply to the label.
    ///   - spacing: Spacing attribute for potential layout needs.
    public init(fontProfile: FontProfile? = nil,
                backgroundColor: ColorScheme? = nil,
                textColor: ColorScheme? = nil,
                effect: Effects? = nil
    ) {
        self.backgroundColor = backgroundColor
        self.fontProfile = fontProfile
        self.textColor = textColor
        self.effect = effect
    }
}
