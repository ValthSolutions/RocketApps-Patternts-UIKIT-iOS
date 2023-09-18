//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 18.09.2023.
//

import UIKit

public struct ColorScheme: Equatable {
    var light: UIColor
    var dark: UIColor
    
    init(light: UIColor = .black, dark: UIColor = .white) {
        self.light = light
        self.dark = dark
    }
    
    var color: UIColor {
        return UIColor { traitCollection in
            switch traitCollection.userInterfaceStyle {
            case .dark:
                return self.dark
            default:
                return self.light
            }
        }
    }
}

