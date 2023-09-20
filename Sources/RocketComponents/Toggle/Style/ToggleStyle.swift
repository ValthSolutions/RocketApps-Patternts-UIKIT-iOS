//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 20.09.2023.
//

import UIKit

/// A style configuration to customize the appearance and behavior of a toggle control.
open class ToggleStyle {
    
    /// Indicates whether the toggle transition is animated.
    var animated: Bool?
    
    /// The duration of the animation for the toggle transition.
    var animationDuration: Double?
    
    /// Color scheme for the toggle when it's in the "on" state.
    var onTintColor: ColorScheme?
    
    /// Color scheme for the toggle when it's in the "off" state.
    var offTintColor: ColorScheme?
    
    /// Color scheme for the toggle's thumb.
    var thumbTintColor: ColorScheme?
    
    /// The size of the toggle's thumb.
    var thumbSize: CGSize?
    
    /// Effects applied to the toggle's thumb, such as haptic feedback.
    var thumbEffects: Effects?
    
    /// Style for the label when the toggle is in the "on" state.
    var labelOnStyle: LabelStyle?
    
    /// Style for the label when the toggle is in the "off" state.
    var labelOffStyle: LabelStyle?
    
    /// Spacing between the toggle's thumb and the associated label.
    var spacing: Spacing?
    
    /// Initializes a new `ToggleStyle` with the provided parameters.
    ///
    /// - Parameters:
    ///   - animated: Specifies whether the toggle transition should be animated. Defaults to `true`.
    ///   - animationDuration: Duration of the toggle's animation transition. Defaults to `0.5`.
    ///   - spacing: The spacing between the toggle's thumb and its associated label. Defaults to `Spacing.step0`.
    ///   - onTintColor: Color scheme for when the toggle is in the "on" state.
    ///   - offTintColor: Color scheme for when the toggle is in the "off" state.
    ///   - thumbTintColor: Color scheme for the toggle's thumb.
    ///   - thumbSize: The size of the toggle's thumb. Defaults to `.zero`.
    ///   - thumbEffects: Effects applied to the toggle's thumb, like haptic feedback.
    ///   - labelOnStyle: Style for the label when the toggle is in the "on" state.
    ///   - labelOffStyle: Style for the label when the toggle is in the "off" state.
    public init(
        animated: Bool? = true,
        animationDuration: Double? = 0.5,
        spacing: Spacing? = Spacing.step0,
        onTintColor: ColorScheme? = ColorScheme(light: UIColor(red: 0.07, green: 0.72, blue: 0.42, alpha: 1),
                                                dark: UIColor(red: 0.07, green: 0.72, blue: 0.42, alpha: 1)),
        offTintColor: ColorScheme? = ColorScheme(light: UIColor(red: 0.8, green: 0.81, blue: 0.82, alpha: 1),
                                                 dark: UIColor(red: 0.8, green: 0.81, blue: 0.82, alpha: 1)),
        thumbTintColor: ColorScheme? = ColorScheme(light: .white, dark: .white),
        thumbSize: CGSize? = .zero,
        thumbEffects: Effects? = Effects(hapticFeedback: .heavy),
        labelOnStyle: LabelStyle? = nil,
        labelOffStyle: LabelStyle? = nil
    ) {
        self.animated = animated
        self.spacing = spacing
        self.animationDuration = animationDuration
        self.thumbTintColor = thumbTintColor
        self.thumbSize = thumbSize
        self.thumbEffects = thumbEffects
        self.onTintColor = onTintColor
        self.offTintColor = offTintColor
        self.labelOnStyle = labelOnStyle
        self.labelOffStyle = labelOffStyle
    }
}
