//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 18.09.2023.
//

import UIKit

public class Button: UIButton, Decoratable {
    public typealias Style = ButtonStyle
    
    private var iconImageView: UIImageView?
    private var stackView: UIStackView?
    
    private var defaultBorderColor: ColorScheme?
    private var pressedBorderColor: ColorScheme?
    private var disabledBorderColor: ColorScheme?
    private var currentStyleType: ButtonStyleType?
    
    public override var isHighlighted: Bool {
        didSet { updateState() }
    }
    
    public override var isEnabled: Bool {
        didSet { updateState() }
    }
    
    public func decorate(with style: Style) {
        switch style.type {
        case .primary:
            setupPrimaryStyle(with: style)
        case .secondary:
            setupSecondaryStyle(with: style)
        }
        
        configureTypography(with: style.fontProfile)
        configureIconAndText(with: style.icon, fontProfile: style.fontProfile, spacing: style.spacing)
        applyEffects(style.effect)
    }
    
    private func setupPrimaryStyle(with style: Style) {
        guard case let .primary(defaultColor, _, _, _) = style.type else { return }
        let pressedColor = style.type.resolvedPressedColor
        let disabledColor = style.type.resolvedDisabledColor
        let iconTint = style.type.resolvedIconTintColor
        
        backgroundColor = defaultColor.color
        setBackgroundImage(UIImage(color: pressedColor.color), for: .highlighted)
        setBackgroundImage(UIImage(color: disabledColor.color), for: .disabled)
        iconImageView?.tintColor = iconTint.color
    }
    
    private func setupSecondaryStyle(with style: Style) {
        guard case let .secondary(borderWidth, defaultColor, _, _, _) = style.type else { return }
        
        let pressedBorderColor = style.type.resolvedPressedColor
        let disabledBorderColor = style.type.resolvedDisabledColor
        let iconTint = style.type.resolvedIconTintColor
        
        layer.borderWidth = borderWidth
        self.defaultBorderColor = defaultColor
        self.pressedBorderColor = pressedBorderColor
        self.disabledBorderColor = disabledBorderColor
        layer.borderColor = defaultColor.color.cgColor
        iconImageView?.tintColor = iconTint.color
    }
    
    private func configureTypography(with fontProfile: FontProfile?) {
        guard let fontProfile = fontProfile else { return }
        self.applyTypography(fontFamily: fontProfile.fontFamily, style: fontProfile.style, text: self.titleLabel?.text ?? "")
    }
    
    private func configureIconAndText(with icon: UIImage?,
                                      fontProfile: FontProfile?,
                                      spacing: Spacing?) {
        guard let icon = icon, stackView == nil else { return }
        let iconIV = UIImageView(image: icon)
        let label = UILabel()
        label.text = self.titleLabel?.text
        label.applyTypography(fontFamily: fontProfile?.fontFamily ?? Typography.defaultFontFamily, style: fontProfile?.style ?? .body1Regular, text: label.text ?? "")
        
        let hStack = UIStackView(arrangedSubviews: [iconIV, label])
        hStack.spacing = spacing?.rawValue ?? Spacing.step3.rawValue
        hStack.alignment = .center
        hStack.axis = .horizontal
        
        self.addSubview(hStack)
        hStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hStack.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            hStack.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        self.stackView = hStack
        self.iconImageView = iconIV
    }
    
    private func applyEffects(_ effect: Effects?) {
        if let shadow = effect?.shadow {
            self.layer.shadowColor = shadow.color.cgColor
            self.layer.shadowOffset = shadow.offset
            self.layer.shadowRadius = shadow.radius
            self.layer.shadowOpacity = shadow.opacity
        }
        
        if let rounded = effect?.rounded, rounded {
            self.layer.cornerRadius = self.bounds.height / 2
        } else if let cornerRadius = effect?.cornerRadius {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    private func updateState() {
        if case .secondary = currentStyleType {
            let borderColor: UIColor? = !isEnabled ? disabledBorderColor?.color : (isHighlighted ? pressedBorderColor?.color : defaultBorderColor?.color)
            layer.borderColor = borderColor?.cgColor
        }
    }
    
}

extension UIImage {
    convenience init(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        UIGraphicsBeginImageContext(size)
        color.setFill()
        UIRectFill(CGRect(origin: .zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.init(data: image.pngData()!)!
    }
}
