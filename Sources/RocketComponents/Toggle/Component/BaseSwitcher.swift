import UIKit
import Combine
import Styling

public class BaseSwitcher: UIControl {
    
    private enum Constants {
        static let prvTitle = "PRV"
        static let proTitle = "PRO"
    }
    
    // MARK: - Properties
    
    public var isPRO: Bool = false
    public let switchTapped = PassthroughSubject<Void, Never>()

    private var animationDuration: Double = 0.5
    private var cornerRadius: CGFloat = 0.33
    private var onPoint = CGPoint.zero
    private var offPoint = CGPoint.zero
    private var isAnimating = false
    private var thumbView = UIView()
    private var proTintColors: [UIColor] = [.black,
                                           .green]
    private var prvTintColors: [UIColor] = [.yellow,
                                            .cyan]
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    override open func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        super.beginTracking(touch, with: event)
        self.animate()
        return true
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    public func setSwitchPosition(for position: Position) {
        isPRO = position != .left
        setupViewsOnAction()
    }
    
    func setUserInteraction(enabled: Bool) {
        self.isUserInteractionEnabled = enabled
    }
}

// MARK: - layoutSubviews

extension BaseSwitcher {
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        if !self.isAnimating {
            layer.cornerRadius = bounds.size.height * cornerRadius
            
            let thumbSize = CGSize(width: 44, height: bounds.height)
            let yPostition = (bounds.size.height - thumbSize.height) / 2
            
            onPoint = CGPoint(x: bounds.size.width - thumbSize.width,
                              y: yPostition)
            offPoint = CGPoint(x: 0,
                               y: yPostition)
            
            thumbView.frame = CGRect(origin: isPRO ? onPoint : offPoint, size: thumbSize)
            thumbView.layer.cornerRadius = thumbSize.height * cornerRadius
        }
    }
}

// MARK: - Private

extension BaseSwitcher {
    
    private func setupUI() {
        clear()
        clipsToBounds = false
        thumbView.backgroundColor = .blue
        thumbView.isUserInteractionEnabled = false
        addSubview(thumbView)
    }
    private func clear() {
        for view in self.subviews {
            view.removeFromSuperview()
        }
    }
    
    private func animate() {
        isPRO = !self.isPRO
        setUserInteraction(enabled: false)
        switchTapped.send()
        
        isAnimating = true
        
        UIView.animate(withDuration: self.animationDuration, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: [UIView.AnimationOptions.curveEaseOut, UIView.AnimationOptions.beginFromCurrentState, UIView.AnimationOptions.allowUserInteraction], animations: {
            self.setupViewsOnAction()
            
        }, completion: { _ in
            self.completeAction()
        })
    }
    
    private func setupViewsOnAction() {
        thumbView.frame.origin.x = isPRO ? onPoint.x : offPoint.x
    }
    
    private func completeAction() {
        isAnimating = false
    }
}
