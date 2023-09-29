//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 19.09.2023.
//

import UIKit
import Combine

public extension UIView {
    enum ShadowLevel {
        case light
        case medium
        case heavy
        
        var shadow: Shadow {
            switch self {
            case .light: return Shadow.light
            case .medium: return Shadow.medium
            case .heavy: return Shadow.heavy
            }
        }
    }
    
    func addShadow(level: ShadowLevel) {
        let shadow = level.shadow
        self.layer.shadowColor = shadow.color.cgColor
        self.layer.shadowOffset = shadow.offset
        self.layer.shadowRadius = shadow.radius
        self.layer.shadowOpacity = shadow.opacity
        self.clipsToBounds = false
    }
    
    @discardableResult
    func addBlur(effectStyle: UIBlurEffect.Style) -> UIVisualEffectView {
        let blurEffect = UIBlurEffect(style: effectStyle)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(blurEffectView)
        
        NSLayoutConstraint.activate([
            blurEffectView.topAnchor.constraint(equalTo: self.topAnchor),
            blurEffectView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            blurEffectView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            blurEffectView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        return blurEffectView
    }
}

public extension UIView {
    func setEdges() {
        guard let superview = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            topAnchor.constraint(equalTo: superview.topAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor)
        ])
    }
}

public extension UIView {
    func createButtonTapPublisher(for button: UIButton) -> AnyPublisher<Void, Never> {
        button.publisher(for: .touchUpInside)
            .map { _ in }
            .eraseToAnyPublisher()
    }
}
