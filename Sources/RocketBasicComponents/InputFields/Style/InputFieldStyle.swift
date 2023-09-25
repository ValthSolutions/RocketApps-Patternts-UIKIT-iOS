//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 19.09.2023.
//

import Styling
import UIKit

/// A struct representing the styling attributes
open class InputFieldStyle {
    
    /// The typography profile specifying the font attributes for the text view.
    /// Uses the `FontProfile` for defined font characteristics.
    var fontProfile: FontProfile?
    
    /// The color scheme for the text color within the text view.
    /// Utilizes the `ColorScheme` for light and dark mode adaptation.
    var textColor: ColorScheme?
    
    /// The visual effects, such as shadows or blurs, to be applied to the text view.
    var effect: Effects?
    
    /// The background color scheme for the text view.
    /// Utilizes the `ColorScheme` for light and dark mode adaptation.
    var backgroundColor: ColorScheme?
    
    /// The color scheme for the placeholder text within the text view,
    /// applicable when the text view is empty.
    /// Utilizes the `ColorScheme` for light and dark mode adaptation.
    var placeholderColor: ColorScheme?
    
    var topLabelColor: ColorScheme?
    
    var errorLabelStyle: LabelStyle?
    
    var topLabelStyle: LabelStyle?
    
    /// Initializes a new `TextViewStyle` with the provided styling attributes.
    ///
    /// - Parameters:
    ///   - fontProfile: The typography profile for the text view's font.
    ///   - backgroundColor: The background color scheme for the text view.
    ///   - textColor: The color scheme for the text within the text view.
    ///   - effect: The visual effects to apply to the text view.
    ///   - placeholderColor: The color scheme for the placeholder text in the text view.
    public init(fontProfile: FontProfile? = FontProfile(style: .caption1Regular),
                backgroundColor: ColorScheme? = nil,
                textColor: ColorScheme? = ColorScheme(light: .black,
                                                      dark: .white),
                topLabelColor: ColorScheme? = ColorScheme(light: .black.withAlphaComponent(0.4), dark: .white.withAlphaComponent(0.4)),
                effect: Effects? = nil,
                placeholderColor: ColorScheme? = nil,
                errorLabelStyle: LabelStyle? = .default,
                topLabelStyle: LabelStyle? = .default
                
    ) {
        self.errorLabelStyle = errorLabelStyle
        self.topLabelStyle = topLabelStyle
        self.backgroundColor = backgroundColor
        self.fontProfile = fontProfile
        self.textColor = textColor
        self.effect = effect
        self.placeholderColor = placeholderColor
    }
}
