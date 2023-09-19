//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 18.09.2023.
//

import UIKit

public struct Effects {
    public var shadow: Shadow?
    public var blur: Blur?
    public var cornerRadius: CGFloat?
    public var rounded: Bool?
    
    public var hapticFeedback: UIImpactFeedbackGenerator.FeedbackStyle?
    public var transformEffect: CGAffineTransform?
    
    public init(shadow: Shadow? = nil,
                blur: Blur? = nil,
                cornerRadius: CGFloat? = nil,
                rounded: Bool? = nil,
                hapticFeedback: UIImpactFeedbackGenerator.FeedbackStyle? = nil,
                transformEffect: CGAffineTransform? = nil
    ) {
        self.shadow = shadow
        self.blur = blur
        self.cornerRadius = cornerRadius
        self.rounded = rounded
        self.hapticFeedback = hapticFeedback
        self.transformEffect = transformEffect
    }
}
