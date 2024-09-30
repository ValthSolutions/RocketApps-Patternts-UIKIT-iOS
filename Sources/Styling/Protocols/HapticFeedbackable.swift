//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 12.10.2023.
//

import UIKit

public protocol HapticFeedbackable {
    var effect: Effects? { get }
    var isHighlighted: Bool { get }
    func handleHaptic()
}

public extension HapticFeedbackable {
    func handleHaptic() {
        guard let effect = self.effect else { return }
        
        if isHighlighted {
            if let hapticStyle = effect.hapticFeedback {
                let generator = UIImpactFeedbackGenerator(style: hapticStyle)
                generator.impactOccurred()
            }
        }
    }
}
