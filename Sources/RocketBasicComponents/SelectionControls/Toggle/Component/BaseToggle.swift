import UIKit
import Styling

open class BaseToggle: UIControl, Decoratable {
    public typealias Style = ToggleStyle

    open var feedbackGenerator: UIImpactFeedbackGenerator? = nil
    
    open var isOn: Bool = true
    open var animated: Bool = false

    open var animationDuration: Double = 0.0
    
    open var spacing: CGFloat = 0 {
        didSet {
            self.layoutSubviews()
        }
    }
    
    open var onTintColor: UIColor = .white {
        didSet {
            self.setupUI()
        }
    }
    
    open var offTintColor: UIColor = .black {
        didSet {
            self.setupUI()
        }
    }
    
    open var cornerRadius: CGFloat {
        get {
            return self.privateCornerRadius
        }
        set {
            if newValue > 0.5 || newValue < 0.0 {
                privateCornerRadius = 0.5
            } else {
                privateCornerRadius = newValue
            }
        }
        
    }
    
    private var privateCornerRadius: CGFloat = 0.5 {
        didSet {
            self.layoutSubviews()
        }
    }
    
    open var thumbTintColor: UIColor = UIColor.white {
        didSet {
            self.thumbView.backgroundColor = self.thumbTintColor
        }
    }
    
    open var thumbCornerRadius: CGFloat {
        get {
            return self.privateThumbCornerRadius
        }
        set {
            if newValue > 0.5 || newValue < 0.0 {
                privateThumbCornerRadius = 0.5
            } else {
                privateThumbCornerRadius = newValue
            }
        }
        
    }
    
    private var privateThumbCornerRadius: CGFloat = 0.5 {
        didSet {
            self.layoutSubviews()
            
        }
    }
    
    public var thumbSize: CGSize = .zero {
        didSet {
            self.layoutSubviews()
        }
    }
    
    open var thumbShadowColor: UIColor = UIColor.black {
        didSet {
            self.thumbView.layer.shadowColor = self.thumbShadowColor.cgColor
        }
    }
    
    open var thumbShadowOffset: CGSize = .zero {
        didSet {
            self.thumbView.layer.shadowOffset = self.thumbShadowOffset
        }
    }
    
    open var thumbShaddowRadius: CGFloat = 0 {
        didSet {
            self.thumbView.layer.shadowRadius = self.thumbShaddowRadius
        }
    }
    
    public var thumbShaddowOppacity: Float = 0 {
        didSet {
            self.thumbView.layer.shadowOpacity = self.thumbShaddowOppacity
        }
    }
    
    // Labels
    
    open var labelOff: UILabel = UILabel()
    open var labelOn: UILabel = UILabel()
    
    open var areLabelsShown: Bool = false {
        didSet {
            self.setupUI()
        }
    }
    
    open var thumbView = ThumbView(frame: CGRect.zero)
    open var onPoint = CGPoint.zero
    open var offPoint = CGPoint.zero
    open var isAnimating = false
    
    private var style: Style?
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupUI()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    public override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        super.beginTracking(touch, with: event)
        
        self.animate()
        return true
    }
    
    open func decorate(with style: Style) {
        self.style = style
        if let animated = style.animated {
            self.animated = animated
        }
        if let onTintColor = style.onTintColor?.color {
            self.onTintColor = onTintColor
        }
        if let offTintColor = style.offTintColor?.color {
            self.offTintColor = offTintColor
        }
        if let thumbTintColor = style.thumbTintColor?.color {
            self.thumbTintColor = thumbTintColor
        }
        if let thumbSize = style.thumbSize {
            self.thumbSize = thumbSize
        }
        if let spacing = style.spacing {
            self.spacing = spacing.rawValue
        }
        if let animationDuration = style.animationDuration {
            self.animationDuration = self.animated ? animationDuration : 0
        }
        
        if let thumbEffects = style.thumbEffects {
            if let shadow = thumbEffects.shadow {
                self.thumbShadowColor = shadow.color
                self.thumbShadowOffset = shadow.offset
                self.thumbShaddowRadius = shadow.radius
                self.thumbShaddowOppacity = shadow.opacity
            }
            
            if let cornerRadius = thumbEffects.cornerRadius {
                self.privateCornerRadius = cornerRadius
            } else if let rounded = thumbEffects.rounded, rounded {
                self.privateCornerRadius = 0.5
            }
        }
        
        if let labelOnStyle = style.labelOnStyle {
            if let textColor = labelOnStyle.textColor?.light {
                self.labelOn.textColor = textColor
            }
            if let fontProfile = labelOnStyle.fontProfile {
                self.labelOn.applyTypography(fontFamily: fontProfile.fontFamily,
                                             style: fontProfile.style,
                                             text: labelOn.text ?? "")
            }
            if let backgroundColor = labelOnStyle.backgroundColor?.color {
                self.labelOn.backgroundColor = backgroundColor
            }
        }
        
        if let labelOffStyle = style.labelOffStyle {
            if let textColor = labelOffStyle.textColor?.light {
                self.labelOff.textColor = textColor
            }
            if let fontProfile = labelOffStyle.fontProfile {
                self.labelOff.applyTypography(fontFamily: fontProfile.fontFamily,
                                              style: fontProfile.style,
                                              text: labelOn.text ?? "")
            }
            if let backgroundColor = labelOffStyle.backgroundColor?.light {
                self.labelOff.backgroundColor = backgroundColor
            }
        }
    }
    
    open func setOn(on: Bool, animated: Bool) {
        if animated && self.animated {
            self.animate(on: on)
        } else {
            self.isOn = on
            self.setupViewsOnAction()
            self.completeAction()
        }
    }
}

// MARK: - Public methods
extension BaseToggle {
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        if !self.isAnimating {
            self.layer.cornerRadius = self.bounds.size.height * self.cornerRadius
            self.backgroundColor = self.isOn ? self.onTintColor : self.offTintColor
            
            // THUMB Management
            // GET THUMB Size, if none set, use one from bounds
            let thumbSize = self.thumbSize != CGSize.zero ? self.thumbSize : CGSize(width: self.bounds.size.height - 4, height: self.bounds.height - 4)
            let yPostition = (self.bounds.size.height - thumbSize.height) / 2
            
            self.onPoint = CGPoint(x: self.bounds.size.width - thumbSize.width - self.spacing, y: yPostition)
            self.offPoint = CGPoint(x: self.spacing, y: yPostition)
            
            self.thumbView.frame = CGRect(origin: self.isOn ? self.onPoint : self.offPoint, size: thumbSize)
            self.thumbView.layer.cornerRadius = thumbSize.height * self.thumbCornerRadius
            
            
            // LABEL Frame
            if self.areLabelsShown {
                let labelWidth = self.bounds.width / 2 - self.spacing * 2
                self.labelOn.frame = CGRect(x: 0, y: 0, width: labelWidth, height: self.frame.height)
                self.labelOff.frame = CGRect(x: self.frame.width - labelWidth, y: 0, width: labelWidth, height: self.frame.height)
            }
        }
    }
}

// MARK: - Private
extension BaseToggle {
    private func setupUI() {
        self.clear()
        
        self.clipsToBounds = false
        
        // Configure THUMB View
        self.thumbView.backgroundColor = self.thumbTintColor
        self.thumbView.isUserInteractionEnabled = false
        
        self.thumbView.layer.shadowColor = self.thumbShadowColor.cgColor
        self.thumbView.layer.shadowRadius = self.thumbShaddowRadius
        self.thumbView.layer.shadowOpacity = self.thumbShaddowOppacity
        self.thumbView.layer.shadowOffset = self.thumbShadowOffset
        
        self.backgroundColor = self.isOn ? self.onTintColor : self.offTintColor
        
        self.addSubview(self.thumbView)
        
        self.setupLabels()
    }
    
    
    private func clear() {
        for view in self.subviews {
            view.removeFromSuperview()
        }
    }
    
    private func animate(on: Bool? = nil) {
        self.isOn = on ?? !self.isOn
        
        self.isAnimating = true
        handleHaptics()
        UIView.animate(withDuration: self.animationDuration, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: [UIView.AnimationOptions.curveEaseOut, UIView.AnimationOptions.beginFromCurrentState, UIView.AnimationOptions.allowUserInteraction], animations: {
            self.setupViewsOnAction()
            
        }, completion: { _ in
            self.completeAction()
        })
    }
    
    private func handleHaptics() {
        if let thumbEffects = style?.thumbEffects,
           let hapticFeedback = thumbEffects.hapticFeedback {
            switch hapticFeedback {
            case .light:
                feedbackGenerator = UIImpactFeedbackGenerator(style: .light)
            case .medium:
                feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
            case .heavy:
                feedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
            case .soft:
                feedbackGenerator = UIImpactFeedbackGenerator(style: .soft)
            case .rigid:
                feedbackGenerator = UIImpactFeedbackGenerator(style: .rigid)
                
            @unknown default:
                break
            }
            feedbackGenerator?.prepare()
            feedbackGenerator?.impactOccurred()
        }
    }
    
    private func setupViewsOnAction() {
        self.thumbView.frame.origin.x = self.isOn ? self.onPoint.x : self.offPoint.x
        self.backgroundColor = self.isOn ? self.onTintColor : self.offTintColor
    }
    
    private func completeAction() {
        self.isAnimating = false
        self.sendActions(for: UIControl.Event.valueChanged)
    }
}

// MARK: - Label's frames
extension BaseToggle {
    private func setupLabels() {
        guard self.areLabelsShown else {
            self.labelOff.alpha = 0
            self.labelOn.alpha = 0
            return
        }
        
        self.labelOff.alpha = 1
        self.labelOn.alpha = 1
        
        let labelWidth = self.bounds.width / 2 - self.spacing * 2
        self.labelOn.frame = CGRect(x: 0, y: 0, width: labelWidth, height: self.frame.height)
        self.labelOff.frame = CGRect(x: self.frame.width - labelWidth, y: 0, width: labelWidth, height: self.frame.height)
        self.labelOn.font = UIFont.boldSystemFont(ofSize: 12)
        self.labelOff.font = UIFont.boldSystemFont(ofSize: 12)
        self.labelOn.textColor = UIColor.white
        self.labelOff.textColor = UIColor.white
        
        self.labelOff.sizeToFit()
        self.labelOff.text = "Off"
        self.labelOn.text = "On"
        self.labelOff.textAlignment = .center
        self.labelOn.textAlignment = .center
        
        self.insertSubview(self.labelOff, belowSubview: self.thumbView)
        self.insertSubview(self.labelOn, belowSubview: self.thumbView)
    }
}
