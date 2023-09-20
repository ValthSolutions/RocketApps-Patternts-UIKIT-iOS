//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 20.09.2023.
//

import Styling
import UIKit

public struct TabBarStyle {
    
    var unselectedItemTintColor: ColorScheme?
    var tintColor: ColorScheme?
    var centerIcon: UIImage?
    
    public init(unselectedItemTintColor: ColorScheme? = nil,
                tintColor: ColorScheme? = nil,
                centerIcon: UIImage? = nil) {
        self.unselectedItemTintColor = unselectedItemTintColor
        self.tintColor = tintColor
        self.centerIcon = centerIcon
    }
}
