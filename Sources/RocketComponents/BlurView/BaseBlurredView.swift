//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 19.09.2023.
//

import UIKit
import Styling

public class BaseBlurredView: UIView {
    
    private var blurEffectView: UIVisualEffectView!
    
    public init(effect: UIBlurEffect.Style = .light) {
        super.init(frame: .zero)
        blurEffectView = self.addBlur(effectStyle: effect)
    }
    
    public func setOpacity(_ opacity: CGFloat) {
        self.alpha = opacity
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
