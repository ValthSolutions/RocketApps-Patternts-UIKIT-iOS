//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 18.09.2023.
//

import UIKit

public struct Shadow {
    var color: UIColor
    var offset: CGSize
    var radius: CGFloat
    var opacity: Float
    
    public init(color: UIColor, offset: CGSize, radius: CGFloat, opacity: Float) {
        self.color = color
        self.offset = offset
        self.radius = radius
        self.opacity = opacity
    }
}
