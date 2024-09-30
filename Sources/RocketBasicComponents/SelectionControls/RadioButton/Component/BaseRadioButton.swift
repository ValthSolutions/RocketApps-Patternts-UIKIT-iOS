import UIKit
import Styling

open class BaseRadioButton: UIButton, Decoratable {
    
    public typealias Style = RadioButtonStyle
    
    open override var isHighlighted: Bool {
        didSet {}
    }
    
    private var borderLayer: CAShapeLayer?
    private var internalLayer: CAShapeLayer?
    private var currentStyle: Style?
    
    // MARK: - Public
    
    open func decorate(with style: Style) {
        self.currentStyle = style
        applyEffects(style.effect)
        clipsToBounds = true
        updateBorder()
        tintColor = UIColor.clear
        adjustsImageWhenHighlighted = false
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        applyRoundedEffect()
        updateBorder()
    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        isSelected.toggle()
        
        handleHaptic()
        updateBorder()
    }
    
    open func applyEffects(_ effect: Effects?) {
        applyShadow(effect?.shadow)
        applyRoundedEffect()
    }
    
    open func applyRoundedEffect() {
        self.layer.cornerRadius = self.bounds.height / 2
    }
    
    open func applyShadow(_ shadow: Shadow?) {
        guard let shadow = shadow else { return }
        self.layer.shadowColor = shadow.color.cgColor
        self.layer.shadowOffset = shadow.offset
        self.layer.shadowRadius = shadow.radius
        self.layer.shadowOpacity = shadow.opacity
    }
}

// MARK: - Effects Configuration

extension BaseRadioButton {
    private func updateBorder() {
        borderLayer?.removeFromSuperlayer()
        internalLayer?.removeFromSuperlayer()

        let proportion: CGFloat = self.bounds.width / (currentStyle?.proportion ?? 48)
        
        let externalBorderLayer = CAShapeLayer()
        externalBorderLayer.path = UIBezierPath(ovalIn: bounds).cgPath
        externalBorderLayer.fillColor = UIColor.clear.cgColor
        externalBorderLayer.strokeColor = currentStyle?.unselectedColor?.color.cgColor
        externalBorderLayer.lineWidth = 10.0 * proportion 
        layer.addSublayer(externalBorderLayer)

        if isSelected {
            guard let currentStyle = currentStyle else { return }
            let padding: CGFloat = 10.0 * proportion
            let internalBorderLayer = CAShapeLayer()
            externalBorderLayer.strokeColor = currentStyle.selectedColor?.color.cgColor
            internalBorderLayer.path = UIBezierPath(ovalIn: bounds.insetBy(dx: padding, dy: padding)).cgPath
            internalBorderLayer.fillColor = currentStyle.selectedColor?.color.cgColor
            internalBorderLayer.strokeColor = UIColor.clear.cgColor
            
            layer.addSublayer(internalBorderLayer)
            self.internalLayer = internalBorderLayer
        }

        self.borderLayer = externalBorderLayer
    }
}

extension BaseRadioButton {
    private func updateBorder2() {
        borderLayer?.removeFromSuperlayer()
        internalLayer?.removeFromSuperlayer()

        let proportion: CGFloat = 48

        let externalBorderLayer = CAShapeLayer()
        externalBorderLayer.path = UIBezierPath(ovalIn: bounds).cgPath
        externalBorderLayer.fillColor = UIColor.clear.cgColor
        externalBorderLayer.strokeColor = currentStyle?.unselectedColor?.color.cgColor
        externalBorderLayer.lineWidth = 10.0 * proportion
        layer.addSublayer(externalBorderLayer)

        if isSelected {
            let padding: CGFloat = 10.0 * proportion
            let internalBorderLayer = CAShapeLayer()
            externalBorderLayer.strokeColor = currentStyle?.selectedColor?.color.cgColor
            internalBorderLayer.path = UIBezierPath(ovalIn: bounds.insetBy(dx: padding, dy: padding)).cgPath
            internalBorderLayer.fillColor = currentStyle?.selectedColor?.color.cgColor
            internalBorderLayer.strokeColor = UIColor.clear.cgColor
            
            layer.addSublayer(internalBorderLayer)
            self.internalLayer = internalBorderLayer
        }

        self.borderLayer = externalBorderLayer
    }
}

// MARK: - Haptics

extension BaseRadioButton: HapticFeedbackable {
    public var effect: Styling.Effects? {
        self.currentStyle?.effect
    }
}
