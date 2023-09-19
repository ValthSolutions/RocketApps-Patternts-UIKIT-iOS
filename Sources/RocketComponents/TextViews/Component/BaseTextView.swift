//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 19.09.2023.
//

import UIKit

public class BaseTextView: UITextView, Decoratable {
    
    public typealias Style = TextViewStyle
    
    public func decorate(with style: Style) {
        
        configureTypography(with: style.fontProfile)
        
        if let backgroundColor = style.backgroundColor {
            applyBackgroundColor(backgroundColor)
        }
        
        if let textColor = style.textColor {
            applyTintColor(textColor)
        }
        
        applyEffects(style.effect)
    }
    
    public func applyBackgroundColor(_ color: Styling.ColorScheme) {
        self.backgroundColor = color.color
    }
    
    public func applyTintColor(_ color: Styling.ColorScheme) {
        self.textColor = color.color
    }
    
    private func configureTypography(with fontProfile: FontProfile?) {
        guard let fontProfile = fontProfile else { return }
        self.applyTypography(fontFamily: fontProfile.fontFamily,
                             style: fontProfile.style,
                             text: self.text ?? "")
    }
    
    private func applyEffects(_ effect: Effects?) {
        applyShadow(effect?.shadow)
        applyRoundedEffect(rounded: effect?.rounded, cornerRadius: effect?.cornerRadius)
    }
    
    private func applyRoundedEffect(rounded: Bool?, cornerRadius: CGFloat?) {
        if let rounded = rounded, rounded {
            self.layer.cornerRadius = self.bounds.height / 2
        } else if let cornerRadius = cornerRadius {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    private func applyShadow(_ shadow: Shadow?) {
        guard let shadow = shadow else { return }
        self.layer.shadowColor = shadow.color.cgColor
        self.layer.shadowOffset = shadow.offset
        self.layer.shadowRadius = shadow.radius
        self.layer.shadowOpacity = shadow.opacity
    }
}
