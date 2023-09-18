//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 18.09.2023.
//

import UIKit

public struct ButtonStyle {
    var type: ButtonStyleType
    var fontProfile: FontProfile?
    var icon: UIImage?
    var effect: Effects?
    var spacing: Spacing?
}

public enum ButtonStyleType: Equatable {
    case primary(defaultColor: ColorScheme,
                 pressedColor: ColorScheme,
                 disabledColor: ColorScheme,
                 iconTintColor: ColorScheme?)
    case secondary(borderWidth: CGFloat,
                   defaultBorderColor: ColorScheme,
                   pressedBorderColor: ColorScheme,
                   disabledBorderColor: ColorScheme,
                   iconTintColor: ColorScheme?)
}
