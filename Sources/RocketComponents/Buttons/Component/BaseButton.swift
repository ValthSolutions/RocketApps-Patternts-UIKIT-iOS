import UIKit

open class BaseButton: UIButton, Decoratable, Iconable, Colorable {
    
    public typealias Style = ButtonStyle
    
    private var iconImageView: UIImageView?
    private var stackView: UIStackView?
    
    private var defaultBorderColor: ColorScheme?
    private var pressedBorderColor: ColorScheme?
    private var disabledBorderColor: ColorScheme?
    private var currentStyleType: ButtonStyleType?
    private var currentEffect: Effects?
    private var originalTransform: CGAffineTransform?
    private var title: String?
    
    // MARK: - Public
    
    open override var isHighlighted: Bool {
        didSet {
            updateState()
            handleTransformAndHaptic()
        }
    }
    
    open override var isEnabled: Bool {
        didSet { updateState() }
    }
    
    open override func setTitle(_ title: String?, for state: UIControl.State) {
        self.title = title
    }
    
    open func decorate(with style: Style) {
        configureStyle(type: style.type)
        configureTypography(with: style.fontProfile)
        configureIconAndText(with: style.icon,
                             fontProfile: style.fontProfile,
                             spacing: style.spacing,
                             textColor: style.textColor,
                             iconPosition: style.iconPosition)
        applyEffects(style.effect)
        if let blurStyle = style.effect?.blur?.style {
            self.addBlur(effectStyle: blurStyle)
        }
        if let transformEffect = style.effect?.transformEffect {
            self.originalTransform = self.transform
            self.currentEffect?.transformEffect = transformEffect
        }
        self.currentEffect = style.effect
        self.clipsToBounds = true
    }
    
    open func applyBackgroundColor(_ color: ColorScheme) {
        self.backgroundColor = color.color
    }
    
    open func applyTintColor(_ color: ColorScheme) {
        self.iconImageView?.tintColor = color.color
    }
    
    open func setIcon(_ image: UIImage) {
        if self.iconImageView == nil {
            self.iconImageView = UIImageView()
            if let stackView = self.stackView {
                stackView.insertArrangedSubview(self.iconImageView!, at: 0)
            }
        }
        self.iconImageView?.image = image
    }
    
    open func setIconTintColor(_ color: ColorScheme) {
        self.iconImageView?.tintColor = color.color
    }
    
    open func setIconVisibility(_ isVisible: Bool) {
        self.iconImageView?.isHidden = !isVisible
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        applyRoundedEffect(rounded: currentEffect?.rounded,
                           cornerRadius: currentEffect?.cornerRadius)
    }
}

// MARK: - Effects Configuration

private extension BaseButton {
    func applyEffects(_ effect: Effects?) {
        applyShadow(effect?.shadow)
        applyRoundedEffect(rounded: effect?.rounded, cornerRadius: effect?.cornerRadius)
    }
    
    func applyRoundedEffect(rounded: Bool?, cornerRadius: CGFloat?) {
        if let rounded = rounded, rounded {
            self.layer.cornerRadius = self.bounds.height / 2
        } else if let cornerRadius = cornerRadius {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    func applyShadow(_ shadow: Shadow?) {
        guard let shadow = shadow else { return }
        self.layer.shadowColor = shadow.color.cgColor
        self.layer.shadowOffset = shadow.offset
        self.layer.shadowRadius = shadow.radius
        self.layer.shadowOpacity = shadow.opacity
    }
}

// MARK: - Typography and Style Configuration

private extension BaseButton {
    func configureStyle(type: ButtonStyleType) {
        currentStyleType = type
        
        switch type {
        case .primary(let defaultColor, _, _, _):
            setupPrimaryStyle(withDefaultColor: defaultColor, type: type)
            
        case .secondary(let borderWidth, let defaultColor, _, _, _):
            setupSecondaryStyle(borderWidth: borderWidth, defaultColor: defaultColor, type: type)
        }
    }
    
    func configureTypography(with fontProfile: FontProfile?) {
        guard let fontProfile = fontProfile else { return }
        self.applyTypography(fontFamily: fontProfile.fontFamily,
                             style: fontProfile.style,
                             text: self.titleLabel?.text ?? "")
    }
    
    func setupPrimaryStyle(withDefaultColor defaultColor: ColorScheme, type: ButtonStyleType) {
        applyBackgroundColor(defaultColor)
        setBackgroundImage(UIImage(color: type.resolvedPressedColor.color,
                                   cornerRadius: self.layer.cornerRadius), for: .highlighted)
        setBackgroundImage(UIImage(color: type.resolvedDisabledColor.color,
                                   cornerRadius: self.layer.cornerRadius), for: .disabled)
        applyTintColor(type.resolvedIconTintColor)
    }
    
    func setupSecondaryStyle(borderWidth: CGFloat, defaultColor: ColorScheme, type: ButtonStyleType) {
        layer.borderWidth = borderWidth
        self.defaultBorderColor = defaultColor
        self.pressedBorderColor = type.resolvedPressedColor
        self.disabledBorderColor = type.resolvedDisabledColor
        layer.borderColor = defaultColor.color.cgColor
        applyTintColor(type.resolvedIconTintColor)
    }
}

// MARK: - Icon and Text Layout

private extension BaseButton {

    func configureIconAndText(with icon: UIImage?,
                              fontProfile: FontProfile?,
                              spacing: Spacing?,
                              textColor: ColorScheme?,
                              iconPosition: Position?
    ) {
        guard let icon = icon, stackView == nil else {
            setupLabel(with: textColor, fontProfile: fontProfile)
            return
        }
        
        let iconIV = createIconView(with: icon)
        configureAndAddStackView(with: iconIV,
                                 textColor: textColor,
                                 fontProfile: fontProfile,
                                 spacing: spacing,
                                 iconPosition: iconPosition)
    }
    
    func setupLabel(with textColor: ColorScheme?, fontProfile: FontProfile?) {
        let label = UILabel()
        label.textColor = textColor?.color
        label.text = title
        label.applyTypography(fontFamily: fontProfile?.fontFamily ?? Typography.defaultFontFamily,
                              style: fontProfile?.style ?? .body1Regular, text: label.text ?? "")
        label.textAlignment = .center
        label.isUserInteractionEnabled = false
        
        self.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    func createIconView(with icon: UIImage) -> UIImageView {
        let iconIV = UIImageView(image: icon)
        return iconIV
    }
    
    func configureAndAddStackView(with iconIV: UIImageView,
                                  textColor: ColorScheme?,
                                  fontProfile: FontProfile?,
                                  spacing: Spacing?,
                                  iconPosition: Position?
    ) {
        let label = UILabel()
        label.textColor = textColor?.color
        label.text = title
        label.applyTypography(fontFamily: fontProfile?.fontFamily ?? Typography.defaultFontFamily,
                              style: fontProfile?.style ?? .body1Regular, text: label.text ?? "")
        label.textAlignment = .center
        label.isUserInteractionEnabled = false
        
        var arrangedSubviews: [UIView] = []
        
        if iconPosition == .left {
            arrangedSubviews = [iconIV, label]
        } else {
            arrangedSubviews = [label, iconIV]
        }
        
        let hStack = UIStackView(arrangedSubviews: arrangedSubviews)
        hStack.spacing = spacing?.rawValue ?? Spacing.step3.rawValue
        hStack.alignment = .center
        hStack.axis = .horizontal
        hStack.isUserInteractionEnabled = true
        
        self.addSubview(hStack)
        hStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hStack.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            hStack.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        hStack.isUserInteractionEnabled = false
        self.stackView = hStack
        self.iconImageView = iconIV
    }
    
    func updateState() {
        if case .secondary = currentStyleType {
            let borderColor: UIColor? = !isEnabled ? disabledBorderColor?.color : (isHighlighted ? pressedBorderColor?.color : defaultBorderColor?.color)
            layer.borderColor = borderColor?.cgColor
        }
        applyRoundedEffect(rounded: currentEffect?.rounded, cornerRadius: currentEffect?.cornerRadius)
    }
}

// MARK: - Transform

private extension BaseButton {
    func handleTransformAndHaptic() {
        guard let effect = currentEffect else { return }
        
        if isHighlighted {
            if let hapticStyle = effect.hapticFeedback {
                let generator = UIImpactFeedbackGenerator(style: hapticStyle)
                generator.impactOccurred()
            }
            
            if let transformEffect = effect.transformEffect {
                animateTransform(to: transformEffect)
            }
        } else {
            animateTransform(to: self.originalTransform ?? CGAffineTransform.identity)
        }
    }
    
    func animateTransform(to transform: CGAffineTransform) {
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.8, options: [], animations: {
            self.transform = transform
        }, completion: nil)
    }
}
