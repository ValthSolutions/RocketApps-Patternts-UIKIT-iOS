//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 18.09.2023.
//

import UIKit

public enum ButtonStyleType: Equatable {
    case primary(defaultColor: UIColor,
                 pressedColor: UIColor,
                 disabledColor: UIColor,
                 iconTintColor: UIColor?)
    case secondary(borderWidth: CGFloat,
                   defaultBorderColor: UIColor,
                   pressedBorderColor: UIColor,
                   disabledBorderColor: UIColor,
                   iconTintColor: UIColor?)
}

public struct ButtonStyle {
    var type: ButtonStyleType
    var fontProfile: FontProfile?
    var icon: UIImage?
    var effect: Effects?
    var spacing: Spacing?
}
