//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 20.09.2023.
//

import UIKit

extension CGFloat {
    var degreesToRadians: CGFloat { return self * .pi / 180 }
    var radiansToDegrees: CGFloat { return self * 180 / .pi }
}

/// `BaseTabBar` is a custom tab bar that provides a circular center button.
/// This class provides methods for setting up and updating the state of the center button.
open class BaseTabBar: UITabBar, Decoratable {
    
    public typealias Style = TabBarStyle
    
    /// The layer that holds the shape around the center button.
    private var shapeLayer: CALayer?
    
    /// The index for the center tab. By default, it is set to 0.
    open var centerTabIndex: Int = 0
    
    
    /// Center button that is displayed prominently on the tab bar.
    private var centerButton: UIButton? {
        didSet {
            updateCenterButtonState()
        }
    }
    
    override init(frame: CGRect) {
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
        
    open func decorate(with style: TabBarStyle) {
        if let unselectedTintColor = style.unselectedItemTintColor {
            self.unselectedItemTintColor = unselectedTintColor.color
        }
        
        if let tintColor = style.tintColor {
            self.tintColor = tintColor.color
        }
        
        if let centerIcon = style.centerIcon {
            centerButton?.setImage(centerIcon, for: .normal)
            centerButton?.setImage(centerIcon, for: .highlighted)
        }
    }
    // MARK: - Init
    
    private func setupInitialState() {
        updateCenterButtonState()
    }
    
    // MARK: - Center Button Methods
    
    /// Updates the appearance of the center button based on whether it is the selected tab.
    open func updateCenterButtonState() {
        if let tabBarVC = findTabBarController() {
            centerButton?.tintColor = (tabBarVC.selectedIndex == centerTabIndex) ? self.tintColor : tabBarVC.tabBar.unselectedItemTintColor
        }
    }
    
    private func setupCenterButton() {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: (self.bounds.width - 56) / 2, y: -28, width: 56, height: 56)
        button.backgroundColor = .gray
        button.layer.cornerRadius = 28
        button.layer.masksToBounds = true
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
        setupCenterButton()
    }
    
    private func addShape() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = createPathCircle()
        shapeLayer.strokeColor = UIColor.lightGray.cgColor
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.lineWidth = 1.0
        
        if let oldShapeLayer = self.shapeLayer {
            self.layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            self.layer.insertSublayer(shapeLayer, at: 0)
        }
        
        self.shapeLayer = shapeLayer
    }
    
    private func createPathCircle() -> CGPath {
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
    
    private func findTabBarController() -> UITabBarController? {
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
    
//    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
//        if let centerButton = self.centerButton, centerButton.frame.contains(point) {
//            return centerButton
//        }
//        return super.hitTest(point, with: event)
//    }
    
    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let buttonRadius: CGFloat = 35
        return abs(self.center.x - point.x) > buttonRadius || abs(point.y) > buttonRadius
    }
}
