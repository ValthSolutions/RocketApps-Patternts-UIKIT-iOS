//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 18.09.2023.
//

import UIKit
import Styling

public enum ButtonStyleType: Equatable {
    case primary(defaultColor: ColorScheme,
                 pressedColor: ColorScheme? = nil,
                 disabledColor: ColorScheme? = nil,
                 iconTintColor: ColorScheme? = nil)
    case secondary(borderWidth: CGFloat,
                   defaultBorderColor: ColorScheme,
                   pressedBorderColor: ColorScheme? = nil,
                   disabledBorderColor: ColorScheme? = nil,
                   iconTintColor: ColorScheme? = nil)
}

public extension ButtonStyleType {
    var resolvedPressedColor: ColorScheme {
        switch self {
        case .primary(let defaultColor, let pressedColor, _, _):
            return pressedColor ?? defaultColor
        case .secondary(_, let defaultBorderColor, let pressedBorderColor, _, _):
            return pressedBorderColor ?? defaultBorderColor
        }
    }
    
    var resolvedDisabledColor: ColorScheme {
        switch self {
        case .primary(let defaultColor, _, let disabledColor, _):
            return disabledColor ?? defaultColor
        case .secondary(_, let defaultBorderColor, _, let disabledBorderColor, _):
            return disabledBorderColor ?? defaultBorderColor
        }
    }
    
    var resolvedIconTintColor: ColorScheme {
        switch self {
        case .primary(let defaultColor, _, _, let iconTintColor):
            return iconTintColor ?? defaultColor
        case .secondary(_, let defaultBorderColor, _, _, let iconTintColor):
            return iconTintColor ?? defaultBorderColor
        }
    }
}
