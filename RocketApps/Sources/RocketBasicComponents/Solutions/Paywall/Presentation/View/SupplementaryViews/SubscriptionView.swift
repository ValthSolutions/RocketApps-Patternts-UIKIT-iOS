import UIKit
import Styling
import ApphudSDK

open class SubscriptionView: NiblessView,
                             Decoratable {
    
    public typealias Style = SubscriptionStyle
    
    public var product: ApphudProduct? {
        didSet {
            updateLabels()
        }
    }
    
    private let containerView = UIView()
    private let topLabel = BaseLabel()
    private let priceLabel = BaseLabel()
    private let bottomLabel = BaseLabel()
    private let radioButton = BaseRadioButton()
    
    public init(product: ApphudProduct? = nil
    ) {
        self.product = product
        super.init(frame: .zero)
        setup()
        updateLabels()
    }
    
    private func setup() {
        setupContainer()
        containerView.addSubview(priceLabel)
        containerView.addSubview(topLabel)
        containerView.addSubview(bottomLabel)
        containerView.addSubview(radioButton)
        setupConstraints()
    }
    
    private func updateLabels() {
        let skProduct = product?.skProduct
        topLabel.text = skProduct?.localizedTitle ?? ""
        priceLabel.text = skProduct?.getLocalizedPrice() ?? ""
        bottomLabel.text = skProduct?.localizedDescription ?? ""
    }
    
    private func setupContainer() {
        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.setEdges()
    }
    
    public func decorate(with style: SubscriptionStyle) {
        radioButton.decorate(with: .init())
        if let topLabelStyle = style.topLabelStyle {
            topLabel.decorate(with: topLabelStyle)
        }
        
        if let priceLabelStyle = style.priceLabelStyle {
            priceLabel.decorate(with: priceLabelStyle)
        }
        
        if let bottomLabelStype = style.bottomLabelStyle {
            bottomLabel.decorate(with: bottomLabelStype)
        }
        
        if let effect = style.effect {
            applyEffects(effect)
        }
    }
    
    private func setupConstraints() {
        makeConstraints { make in
            make.height.greaterThanOrEqualTo(100)
        }
        
        radioButton.makeConstraints { make in
            make.centerY.equalTo(containerView.centerYAnchor)
            make.trailing.equalTo(containerView.trailingAnchor).offset(-12)
            make.width.equalTo(24)
            make.width.equalTo(24)
        }
        
        topLabel.makeConstraints { make in
            make.top.equalTo(containerView.topAnchor).offset(12)
            make.bottom.equalTo(priceLabel.topAnchor).offset(-4)
            make.leading.equalTo(containerView.leadingAnchor).offset(12)
            make.trailing.equalTo(containerView.trailingAnchor).offset(-12)
        }
        
        priceLabel.makeConstraints { make in
            make.leading.equalTo(containerView.leadingAnchor).offset(12)
            make.bottom.equalTo(bottomLabel.topAnchor).offset(-12)
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
