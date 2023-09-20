//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 20.09.2023.
//

import UIKit

public struct ToggleStyle {
    var animated: Bool?
    var animationDuration: Double?
    var onTintColor: ColorScheme?
    var offTintColor: ColorScheme?
    var thumbTintColor: ColorScheme?
    var thumbSize: CGSize?
    var thumbEffects: Effects?
    var labelOnStyle: LabelStyle?
    var labelOffStyle: LabelStyle?
    var spacing: Spacing?
    
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
