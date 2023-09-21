import UIKit

open class CheckBoxButton: UIButton, Decoratable {
    
    public typealias Style = CheckBoxStyle
    
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
        applyRoundedEffect(currentStyle?.effect?.cornerRadius)
        updateBorder()
    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        isSelected.toggle()
        
        handleTransformAndHaptic()
        updateBorder()
    }
    
    open func applyEffects(_ effect: Effects?) {
        applyShadow(effect?.shadow)
        applyRoundedEffect(effect?.cornerRadius)
    }
    
    open func applyRoundedEffect(_ cornerRadius: CGFloat?) {
        guard let cornerRadius else { return }
        self.layer.cornerRadius = cornerRadius
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

extension CheckBoxButton {
    private func updateBorder() {
        borderLayer?.removeFromSuperlayer()
        internalLayer?.removeFromSuperlayer()
        
        let proportion: CGFloat = self.bounds.width / (currentStyle?.proportion ?? 48)
        let cornerRadiusValue = currentStyle?.effect?.cornerRadius ?? 0
        
        let externalBorderLayer = CAShapeLayer()
        externalBorderLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadiusValue).cgPath
        externalBorderLayer.fillColor = UIColor.clear.cgColor
        externalBorderLayer.strokeColor = currentStyle?.unselectedColor?.color.cgColor
        externalBorderLayer.lineWidth = 10.0 * proportion
        layer.addSublayer(externalBorderLayer)
        
        if isSelected {
            guard let currentStyle = currentStyle else { return }
            
            let internalBorderLayer = CAShapeLayer()
            internalBorderLayer.path = UIBezierPath(roundedRect: bounds,
                                                    cornerRadius: cornerRadiusValue).cgPath
            internalBorderLayer.fillColor = currentStyle.selectedColor?.color.cgColor
            internalBorderLayer.strokeColor = UIColor.clear.cgColor
            layer.addSublayer(internalBorderLayer)
            
            let checkmarkLayer = CAShapeLayer()
            checkmarkLayer.path = checkmarkBezierPath().cgPath
            checkmarkLayer.strokeColor = UIColor.white.cgColor
            checkmarkLayer.lineWidth = 5.0 * proportion
            checkmarkLayer.fillColor = UIColor.clear.cgColor
            checkmarkLayer.lineCap = .round
            checkmarkLayer.lineJoin = .round
            layer.addSublayer(checkmarkLayer)
            
            self.internalLayer = internalBorderLayer
        }
        
        self.borderLayer = externalBorderLayer
    }
    
    private func checkmarkBezierPath() -> UIBezierPath {
        let checkmark = UIBezierPath()
        let bounds = self.bounds
        let xShift: CGFloat = -0.05 * bounds.width
            
        let startPoint = CGPoint(x: bounds.minX + 0.3 * bounds.width + xShift,
                                 y: bounds.midY)
        let middlePoint = CGPoint(x: bounds.midX + xShift,
                                  y: bounds.minY + 0.75 * bounds.height)
        let endPoint = CGPoint(x: bounds.minX + 0.8 * bounds.width + xShift,
                               y: bounds.minY + 0.2 * bounds.height)
        
        checkmark.move(to: startPoint)
        checkmark.addLine(to: middlePoint)
        checkmark.addLine(to: endPoint)
        
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let rotationAngle: CGFloat = .pi / 18
        checkmark.apply(CGAffineTransform(translationX: -center.x, y: -center.y))
        checkmark.apply(CGAffineTransform(rotationAngle: rotationAngle))
        checkmark.apply(CGAffineTransform(translationX: center.x, y: center.y))
        
        return checkmark
    }
}

// MARK: - Haptics

private extension CheckBoxButton {
    func handleTransformAndHaptic() {
        guard let effect = currentStyle?.effect else { return }
        
        if isHighlighted {
            if let hapticStyle = effect.hapticFeedback {
                let generator = UIImpactFeedbackGenerator(style: hapticStyle)
                generator.impactOccurred()
            }
        }
    }
}
