import UIKit
import Styling

open class BenefitView: NiblessView,
                        Decoratable {
    
    public typealias Style = BenefitStyle
    
    private let termsLabel = BaseLabel()
    private let privacyLabel = BaseLabel()
    private let restorePurchaseButton = UIButton()
    
    public var onTermsTapped: (() -> Void)?
    public var onPrivacyTapped: (() -> Void)?
    public var onRestorePurchaseTapped: (() -> Void)?
    
    public init() {
        super.init(frame: .zero)
        setup()
    }
    
    private func setup() {
        setupStackView()
        termsLabel.text = "Terms"
        termsLabel.textColor = .black
        termsLabel.isUserInteractionEnabled = true
        let termsTapGesture = UITapGestureRecognizer(target: self, action: #selector(termsTapped))
        termsLabel.addGestureRecognizer(termsTapGesture)
        
        privacyLabel.text = "Privacy"
        privacyLabel.textColor = .black
        privacyLabel.isUserInteractionEnabled = true
        let privacyTapGesture = UITapGestureRecognizer(target: self, action: #selector(privacyTapped))
        privacyLabel.addGestureRecognizer(privacyTapGesture)
        
        restorePurchaseButton.setTitle("Restore to Purchase", for: .normal)
        restorePurchaseButton.addTarget(self, action: #selector(restorePurchaseTapped), for: .touchUpInside)
    }
    
    public func decorate(with style: BenefitStyle) {

    }
    
    private func setupStackView() {
        let stackView = UIStackView(arrangedSubviews: [termsLabel,
                                                       privacyLabel,
                                                       restorePurchaseButton])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.setEdges()
    }
    
    @objc func termsTapped() {
        onTermsTapped?()
    }
    
    @objc func privacyTapped() {
        onPrivacyTapped?()
    }
    
    @objc func restorePurchaseTapped() {
        onRestorePurchaseTapped?()
    }
}
