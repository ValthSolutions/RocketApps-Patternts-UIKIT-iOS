//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 19.09.2023.
//

import Styling

public struct TextViewStyle {
    
    var fontProfile: FontProfile?
    
    var textColor: ColorScheme?
    
    var effect: Effects?
    
    var spacing: Spacing?
    
    var backgroundColor: ColorScheme?
    
    var placeholderColor: ColorScheme? 
    
    public init(fontProfile: FontProfile? = nil,
                backgroundColor: ColorScheme? = nil,
                textColor: ColorScheme? = nil,
                effect: Effects? = nil,
                spacing: Spacing? = nil,
                placeholderColor: ColorScheme? = nil
    ) {
        self.backgroundColor = backgroundColor
        self.fontProfile = fontProfile
        self.textColor = textColor
        self.effect = effect
        self.spacing = spacing
        self.placeholderColor = placeholderColor
    }
}
