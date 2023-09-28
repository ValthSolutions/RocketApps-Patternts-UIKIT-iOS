import UIKit
import Styling

open class PreviewSubscriptionView: NiblessView,
                                    Decoratable {
    
    public typealias Style = BenefitStyle
    
    private let imageView = UIImageView()
    private let topLabel = BaseLabel()
    private let bottomLabel = BaseLabel()
    
    private let containerView = UIView()
    
    public init() {
        super.init(frame: .zero)
        setup()
    }
    
    private func setup() {
        setupContainer()
        containerView.addSubview(imageView)
        containerView.addSubview(topLabel)
        containerView.addSubview(bottomLabel)
        setupConstraints()
    }
    
    private func setupContainer() {
        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.setEdges()
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
            make.leading.equalTo(containerView.leadingAnchor).offset(12)
            make.top.equalTo(containerView.topAnchor).offset(12)
            make.bottom.equalTo(topLabel.topAnchor).offset(-12)
        }
        
        topLabel.makeConstraints { make in
            make.leading.equalTo(containerView.leadingAnchor).offset(12)
            make.trailing.equalTo(containerView.trailingAnchor).offset(-12)
        }
        
        bottomLabel.makeConstraints { make in
            make.leading.equalTo(containerView.leadingAnchor).offset(12)
            make.bottom.equalTo(containerView.bottomAnchor).offset(-12)
        }
    }
    
    private func applyEffects(_ effect: Effects?) {
        applyShadow(effect?.shadow)
        applyRoundedCorners(cornerRadius: effect?.cornerRadius)
    }
    
    private func applyRoundedCorners(cornerRadius: CGFloat?) {
        if let cornerRadius = cornerRadius {
            containerView.layer.cornerRadius = cornerRadius
        }
    }
    
    private func applyShadow(_ shadow: Shadow?) {
        guard let shadow = shadow else { return }
        containerView.backgroundColor = .white
        containerView.layer.shadowColor = shadow.color.cgColor
        containerView.layer.shadowOffset = shadow.offset
        containerView.layer.shadowRadius = shadow.radius
        containerView.layer.shadowOpacity = shadow.opacity
    }
}
