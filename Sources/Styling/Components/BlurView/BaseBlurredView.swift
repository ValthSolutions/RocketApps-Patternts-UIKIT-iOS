//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 19.09.2023.
//

import UIKit

public class BaseBlurredView: UIView {
    
    private let blurEffectView: UIVisualEffectView
    
    public init(effect: UIBlurEffect.Style = .light) {
        blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: effect))
        super.init(frame: .zero)
        
        setup()
    }
    
    public func setOpacity(_ opacity: CGFloat) {
        self.alpha = opacity
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(blurEffectView)
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            blurEffectView.topAnchor.constraint(equalTo: self.topAnchor),
            blurEffectView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            blurEffectView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            blurEffectView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}
