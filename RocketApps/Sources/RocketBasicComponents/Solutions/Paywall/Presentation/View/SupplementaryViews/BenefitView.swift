import UIKit
import Styling

open class BenefitView: NiblessView,
                        Decoratable {
    
    public typealias Style = BenefitStyle
    
    private let imageView = UIImageView()
    private let topLabel = BaseLabel()
    private let bottomLabel = BaseLabel()
    
    public init() {
        super.init(frame: .zero)
        setup()
    }
    
    private func setup() {
        [imageView, topLabel, bottomLabel].forEach { addSubview($0) }
        setupConstraints()
        backgroundColor = .gray
    }
    
    public func decorate(with style: BenefitStyle) {
        if let topLabelStyle = style.topLabelStyle {
            topLabel.decorate(with: topLabelStyle)
        }
        
        if let bottomLabelStype = style.bottomLabelStyle {
            bottomLabel.decorate(with: bottomLabelStype)
        }
        
        if let effect = style.effect {
            applyEffects(effect)
        }
        
        topLabel.text = style.topText
        bottomLabel.text = style.bottomText
        imageView.image = style.icon
        topLabel.numberOfLines = 0
    }
    
    private func setupConstraints() {
        makeConstraints { make in
            make.height.greaterThanOrEqualTo(146)
            make.width.equalTo(192)
        }
        
        imageView.makeConstraints { make in
            make.leading.equalTo(leadingAnchor).offset(12)
            make.top.equalTo(topAnchor).offset(12)
            make.bottom.equalTo(topLabel.topAnchor).offset(-12)
        }
        
        topLabel.makeConstraints { make in
            make.leading.equalTo(leadingAnchor).offset(12)
        }
        
        bottomLabel.makeConstraints { make in
            make.leading.equalTo(leadingAnchor).offset(12)
            make.bottom.equalTo(bottomAnchor).offset(-12)
        }
    }
    
    private func applyEffects(_ effect: Effects?) {
        applyShadow(effect?.shadow, cornerRadius: effect?.cornerRadius)
        applyRoundedCorners(cornerRadius: effect?.cornerRadius)
    }
    
    private func applyRoundedCorners(cornerRadius: CGFloat?) {
        if let cornerRadius = cornerRadius {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    private func applyShadow(_ shadow: Shadow?, cornerRadius: CGFloat?) {
        guard let shadow = shadow else { return }
        let shadowPath0 = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius ?? 0)
        self.layer.shadowPath = shadowPath0.cgPath
        self.layer.shadowColor = shadow.color.cgColor
        self.layer.shadowOffset = shadow.offset
        self.layer.shadowRadius = shadow.radius
        self.layer.shadowOpacity = shadow.opacity
    }
}
