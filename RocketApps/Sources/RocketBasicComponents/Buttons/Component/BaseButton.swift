import UIKit
import Styling

open class BaseButton: UIButton,
                       Decoratable,
                       Iconable,
                       Colorable,
                       TypographyButtonApplicable {
    
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
    private var styles: [Int: ButtonStyle] = [:]
    
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
    
    open func setStyle(_ style: Style, for state: UIButton.State) {
        styles[Int(state.rawValue)] = style
        
        if self.state == state {
            applyStyle(style)
        }
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
    
    open func applyStyle(_ style: Style) {
        decorate(with: style)
        switch style.type {
        case .primary(let defaultColor, _, _, _):
            setupPrimaryStyle(withDefaultColor: defaultColor, type: style.type)
        case .secondary(let borderWidth, let defaultColor, _, _, _):
            setupSecondaryStyle(borderWidth: borderWidth, defaultColor: defaultColor, type: style.type)
        }
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
                              iconPosition: Position?) {
        guard let icon = icon, stackView == nil else {
            self.setTitle(title, for: .normal)
            if let fontProfile = fontProfile {
                applyTypography(fontFamily: fontProfile.fontFamily,
                                style: fontProfile.style,
                                text: title ?? "")
            }
            if let textColor = textColor {
                setTitleColor(textColor.color, for: .normal)
            }
            return
        }
        
        let iconIV = createIconView(with: icon)
        let textButton = UIButton()
        textButton.setTitle(title, for: .normal)
        textButton.isUserInteractionEnabled = false
        if let fontProfile = fontProfile {
            textButton.setAttributedTitle(Typography.attributedString(for: fontProfile,
                                                                      text: self.titleLabel?.text ?? ""),
                                          for: .normal)
        }
        if let textColor = textColor {
            textButton.setTitleColor(textColor.color, for: .normal)
        }

        configureAndAddStackView(with: iconIV,
                                 textButton: textButton,
                                 spacing: spacing,
                                 iconPosition: iconPosition)
    }
    
    func configureAndAddStackView(with iconIV: UIImageView,
                                  textButton: UIButton,
                                  spacing: Spacing?,
                                  iconPosition: Position?) {

        var arrangedSubviews: [UIView] = []
        
        if iconPosition == .left {
            arrangedSubviews = [iconIV, textButton]
        } else if iconPosition == .right {
            arrangedSubviews = [textButton, iconIV]
        }
        
        let hStack = UIStackView(arrangedSubviews: arrangedSubviews)
        hStack.spacing = spacing?.rawValue ?? Spacing.step3.rawValue
        hStack.alignment = .center
        hStack.axis = .horizontal
            
        self.addSubview(hStack)
        hStack.translatesAutoresizingMaskIntoConstraints = false
        hStack.setEdges()
        hStack.isUserInteractionEnabled = false
        self.stackView = hStack
        self.iconImageView = iconIV
    }
    
    
    func createIconView(with icon: UIImage) -> UIImageView {
        let iconIV = UIImageView(image: icon)
        return iconIV
    }
    
    func updateState() {
        if let style = styles[Int(self.state.rawValue)] {
            applyStyle(style)
            if case .secondary = currentStyleType {
                let borderColor: UIColor? = !isEnabled ? disabledBorderColor?.color : (isHighlighted ? pressedBorderColor?.color : defaultBorderColor?.color)
                layer.borderColor = borderColor?.cgColor
            }
            applyRoundedEffect(rounded: currentEffect?.rounded, cornerRadius: currentEffect?.cornerRadius)
        }
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
        UIView.animate(
            withDuration: 0.4,
            delay: 0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 3,
            options: [.curveEaseInOut],
            animations: {
                self.transform = transform
            }
        )
    }
}
