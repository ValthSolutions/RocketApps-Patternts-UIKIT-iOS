//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 18.09.2023.
//

import UIKit

public struct Shadow {
    public var color: UIColor
    public var offset: CGSize
    public var radius: CGFloat
    public var opacity: Float
    
    public init(color: UIColor, offset: CGSize, radius: CGFloat, opacity: Float) {
        self.color = color
        self.offset = offset
        self.radius = radius
        self.opacity = opacity
    }
}

public extension Shadow {
    static var light: Shadow {
        return Shadow(color: .black, offset: CGSize(width: 0, height: 2), radius: 6, opacity: 0.03)
    }
    
    static var medium: Shadow {
        return Shadow(color: .black, offset: CGSize(width: 0, height: 5), radius: 6, opacity: 0.06)
    }
    
    static var heavy: Shadow {
        return Shadow(color: .black, offset: CGSize(width: 0, height: 5), radius: 6, opacity: 0.12)
    }
}
