//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 19.09.2023.
//

import UIKit

class Skeleton {
    // MARK: - Button Styles
    struct ButtonStyles {
        static var primary: ButtonStyle {
            return ButtonStyle(
                type: .primary(
                    defaultColor: ColorScheme(light: .darkGray, dark: .lightGray),
                    pressedColor: ColorScheme(light: .red, dark: .yellow),
                    disabledColor: ColorScheme(light: .lightGray, dark: .darkGray)
                ),
                fontProfile: FontProfile(style: .title3Bold),
                icon: nil,
                effect:
                    Effects(shadow: Shadow(color: .black,
                                           offset: CGSize(width: 0, height: 2),
                                           radius: 4, opacity: 0.2), cornerRadius: 8),
                spacing: .step5
            )
        }
        
        static var secondary: ButtonStyle {
            return ButtonStyle(
                type: .secondary(borderWidth: 4,
                                 defaultBorderColor: ColorScheme(light: .darkGray, dark: .lightGray),
                                 pressedBorderColor: ColorScheme(light: .red, dark: .yellow),
                                 disabledBorderColor: ColorScheme(light: .lightGray, dark: .darkGray)
                                ),
                fontProfile: FontProfile(style: .largeTitle),
                icon: nil,
                effect:
                    Effects(cornerRadius: 8)
            )
        }
    }
    
    // MARK: - Label Styles
    struct LabelStyles {
        static var title: LabelStyle {
            return LabelStyle(
                fontProfile: FontProfile(style: .largeTitle),
                backgroundColor: .init(ColorScheme(light: .blue, dark: .brown)),
                textColor: .init(ColorScheme(light: .brown, dark: .blue)),
                effect: Effects(shadow: Shadow(color: .cyan,
                                               offset: CGSize(width: 10, height: 5),
                                               radius: 19,
                                               opacity: 1.0))
            )
        }
    }
}
