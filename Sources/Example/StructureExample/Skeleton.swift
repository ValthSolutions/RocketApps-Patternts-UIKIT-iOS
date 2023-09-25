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
                icon: UIImage(systemName: "moon"),
                iconPosition: .right,
                effect:
                    Effects(shadow: Shadow(color: .black,
                                           offset: CGSize(width: 0, height: 2),
                                           radius: 4, opacity: 0.2),
                            cornerRadius: 8,
                            hapticFeedback: .heavy,
                            transformEffect: CGAffineTransform(scaleX: 0.95, y: 0.95)
                     ),
                spacing: .step1,
                textColor: ColorScheme(light: .red, dark: .brown)
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
    
    // MARK: - PageControl Styles
    struct PageControlStyles {
        static var defaultStyle: PageControlStyle {
            return PageControlStyle(
                currentPageIndicatorTintColor: ColorScheme(light: .blue, dark: .cyan),
                pageIndicatorTintColor: ColorScheme(light: .gray, dark: .darkGray)
            )
        }
    }
    
    // MARK: - TextView Styles
    struct TextViewStyles {
        static var defaultStyle: InputFieldStyle {
            return InputFieldStyle(fontProfile: FontProfile(style: .title3Bold),
                                 backgroundColor: ColorScheme(light: .lightGray, dark: .black),
                                 textColor: ColorScheme(light: .black, dark: .white),
                                 spacing: Spacing.step4,
                                 placeholderColor: ColorScheme(light: .gray, dark: .lightGray)))
        }
    }
}
