//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 19.09.2023.
//

import UIKit
import Styling

public struct LabelStyle {
    
    var fontProfile: FontProfile?
    
    var textColor: ColorScheme?
    
    var effect: Effects?
    
    var spacing: Spacing?
    
    var backgroundColor: ColorScheme?
    
    public init(fontProfile: FontProfile? = nil,
                backgroundColor: ColorScheme? = nil,
                textColor: ColorScheme? = nil,
                effect: Effects? = nil,
                spacing: Spacing? = nil
    ) {
        self.backgroundColor = backgroundColor
        self.fontProfile = fontProfile
        self.textColor = textColor
        self.effect = effect
        self.spacing = spacing
    }
}
