//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 21.09.2023.
//

import UIKit

public struct ColorConstants {
    public static let defaultOnTintColor = ColorScheme(light: UIColor(red: 0.07, green: 0.72, blue: 0.42, alpha: 1),
                                                dark: UIColor(red: 0.07, green: 0.72, blue: 0.42, alpha: 1))
    public static let defaultOffTintColor = ColorScheme(light: UIColor(red: 0.8, green: 0.81, blue: 0.82, alpha: 1),
                                                 dark: UIColor(red: 0.8, green: 0.81, blue: 0.82, alpha: 1))
    public static let defaultThumbTintColor = ColorScheme(light: .white, dark: .white)
    
    public static let defaultSelectedColor = ColorScheme(light: .cyan, dark: .cyan)
    
    public static let defaultUnselectedColor = ColorScheme(light: .lightGray, dark: .lightGray)
}
