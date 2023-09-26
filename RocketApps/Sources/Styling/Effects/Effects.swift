//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 18.09.2023.
//

import UIKit

/// Represents a collection of visual and interactive effects that can be applied to UI components.
public struct Effects {
    
    /// Defines the shadow effect.
    public var shadow: Shadow?
    
    /// Represents the blur effect.
    public var blur: Blur?
    
    /// The corner radius applied to the UI component.
    public var cornerRadius: CGFloat?
    
    /// A boolean value indicating if the UI component should be fully rounded, usually for circle-like visuals.
    public var rounded: Bool?
    
    /// The type of haptic feedback to provide when a user interacts with the UI component.
    public var hapticFeedback: UIImpactFeedbackGenerator.FeedbackStyle?
    
    /// A transformation effect applied to the UI component.
    public var transformEffect: CGAffineTransform?
    
    
    /// Initializes a new Effects object with the provided parameters.
    /// - Parameters:
    ///   - shadow: The shadow effect to apply.
    ///   - blur: The blur effect to apply.
    ///   - cornerRadius: The corner radius of the UI component.
    ///   - rounded: A flag indicating if the UI component should be fully rounded.
    ///   - hapticFeedback: The type of haptic feedback to provide.
    ///   - transformEffect: A transformation effect to apply.
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
