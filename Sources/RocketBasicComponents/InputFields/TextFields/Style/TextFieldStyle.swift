//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 22.09.2023.
//

import UIKit
import Styling

public struct TextFieldStyle {
    let placeholderColor: UIColor
    let fontProfile: FontProfile?
    let editingBorderColor: UIColor
    let normalBorderColor: UIColor
    let errorColor: UIColor
    let normalTextColor: UIColor
    let topLabelColor: UIColor
    let isAnimated: Bool
    
    public init(
        placeholderColor: UIColor = .black.withAlphaComponent(0.4),
        fontProfile: FontProfile? = nil,
        editingBorderColor: UIColor = .red,
        normalBorderColor: UIColor = .blue,
        errorColor: UIColor = .red,
        normalTextColor: UIColor = .black,
        topLabelColor: UIColor = .black,
        isAnimated: Bool = true
    ) {
        self.placeholderColor = placeholderColor
        self.fontProfile = fontProfile
        self.editingBorderColor = editingBorderColor
        self.normalBorderColor = normalBorderColor
        self.errorColor = errorColor
        self.normalTextColor = normalTextColor
        self.topLabelColor = topLabelColor
        self.isAnimated = isAnimated
    }
}
