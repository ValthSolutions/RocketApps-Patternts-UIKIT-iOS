import UIKit
import Styling

extension CGFloat {
    var degreesToRadians: CGFloat { return self * .pi / 180 }
    var radiansToDegrees: CGFloat { return self * 180 / .pi }
}

/// `BaseTabBar` is a custom tab bar that provides a circular center button.
/// This class provides methods for setting up and updating the state of the center button.
open class BaseCenteredTabBar: UITabBar, Decoratable {
    
    public typealias Style = CenteredTabBarStyle
    
    /// The layer that holds the shape around the center button.
    open var shapeLayer: CALayer?
    
    /// The index for the center tab. By default, it is set to 0.
    open var centerTabIndex: Int = 0
    
    /// Center button that is displayed prominently on the tab bar.
    open var centerButton: UIButton? {
        didSet {
            updateCenterButtonState()
        }
    }
    
    private var currentStyle: CenteredTabBarStyle?

    // MARK: - Init
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        updateCenterButtonState()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override var selectedItem: UITabBarItem? {
        didSet {
            updateCenterButtonState()
        }
    }
    
    open func decorate(with style: CenteredTabBarStyle) {
        currentStyle = style

        if let shadowTabBarEffect = style.shadowEffectTabBar {
            addShadow(shadowEffect: shadowTabBarEffect)
        }
        
        if centerButton == nil {
            setupCenterButton()
        }
        
        if let shadowButtonEffect = style.shadowEffectButton {
            addShadowToButton(shadowEffect: shadowButtonEffect)
        }
        
        if let unselectedTintColor = style.unselectedItemTintColor {
            self.unselectedItemTintColor = unselectedTintColor.color
        }
        
        if let tintColor = style.tintColor {
            self.tintColor = tintColor.color
        }
        
        if let centerIcon = style.centerIcon?.withRenderingMode(.alwaysTemplate) {
            centerButton?.setImage(centerIcon, for: .normal)
            centerButton?.setImage(centerIcon, for: .highlighted)
        }
    }
    
    // MARK: - Center Button Methods
    
    /// Updates the appearance of the center button based on whether it is the selected tab.
    open func updateCenterButtonState() {
        guard let tabBarVC = findTabBarController() else { return }
        let isSelected = tabBarVC.selectedIndex == centerTabIndex
        let colorScheme = isSelected ? currentStyle?.centerIconSelectionColor?.on : currentStyle?.centerIconSelectionColor?.off
        let currentMode = traitCollection.userInterfaceStyle
        let color: UIColor = currentMode == .dark ? colorScheme?.dark ?? .white : colorScheme?.light ?? .white
        centerButton?.tintColor = color
    }
    
    open func setupCenterButton() {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: (self.bounds.width - 56) / 2, y: -28, width: 56, height: 56)
        button.backgroundColor = .gray
        button.layer.cornerRadius = 28
        button.addTarget(self, action: #selector(centerButtonTapped), for: .touchUpInside)
        self.addSubview(button)
        self.centerButton = button
        updateCenterButtonState()
    }
    
    @objc private func centerButtonTapped() {
        if let tabBarVC = findTabBarController() {
            tabBarVC.selectedIndex = centerTabIndex
            updateCenterButtonState()
        }
    }
    
    // MARK: - Shape Methods
    
    open override func draw(_ rect: CGRect) {
        addShape()
    }
    
    open func addShape() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = createPathCircle()
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.lineWidth = 1.0
        
        if let oldShapeLayer = self.shapeLayer {
            self.layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            if let firstSubviewLayer = self.subviews.first?.layer {
                self.layer.insertSublayer(shapeLayer, below: firstSubviewLayer)
            } else {
                self.layer.addSublayer(shapeLayer)
            }
        }
        
        self.shapeLayer = shapeLayer
    }
    
    open func addShadowToButton(shadowEffect: Shadow) {
        guard let centerButton = self.centerButton else { return }
        
        centerButton.layer.shadowColor = shadowEffect.color.cgColor
        centerButton.layer.shadowOpacity = shadowEffect.opacity
        centerButton.layer.shadowOffset = shadowEffect.offset
        centerButton.layer.shadowRadius = shadowEffect.radius
        centerButton.layer.shadowPath = UIBezierPath(roundedRect: centerButton.bounds, cornerRadius: centerButton.layer.cornerRadius).cgPath
    }
    
    open func addShadow(shadowEffect: Shadow) {
        self.layer.shadowColor = shadowEffect.color.cgColor
        self.layer.shadowOpacity = shadowEffect.opacity
        self.layer.shadowOffset = shadowEffect.offset
        self.layer.shadowRadius = shadowEffect.radius
        self.layer.shadowPath = createPathCircle()
    }
    
    open func createPathCircle() -> CGPath {
        let radius: CGFloat = 37.0
        let path = UIBezierPath()
        let centerWidth = self.frame.width / 2
        
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: (centerWidth - radius * 2), y: 0))
        path.addArc(withCenter: CGPoint(x: centerWidth, y: 0),
                    radius: radius,
                    startAngle: CGFloat(180).degreesToRadians, endAngle: CGFloat(0).degreesToRadians, clockwise: false)
        path.addLine(to: CGPoint(x: self.frame.width, y: 0))
        path.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
        path.addLine(to: CGPoint(x: 0, y: self.frame.height))
        path.close()
        return path.cgPath
    }
    
    // MARK: - Helper Methods
    
    open func findTabBarController() -> UITabBarController? {
        var nextResponder = self.next
        while nextResponder != nil {
            if let tabBarVC = nextResponder as? UITabBarController {
                return tabBarVC
            }
            nextResponder = nextResponder?.next
        }
        return nil
    }
    
    // MARK: - Touch Handling
    
    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if let centerButton = self.centerButton, centerButton.frame.contains(point) {
            return centerButton
        }
        return super.hitTest(point, with: event)
    }
}
