import UIKit
import Styling

open class RegistrationFooterView: NiblessView,
                                   Decoratable {
    
    public typealias Style = FooterStyle
    
    private let termsLabel = BaseLabel()
    private let privacyLabel = BaseLabel()
    private let restorePurchaseButton = BaseButton()
    
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
        
        restorePurchaseButton.setTitle("Restore", for: .normal)
        restorePurchaseButton.addTarget(self, action: #selector(restorePurchaseTapped), for: .touchUpInside)
    }
    
    public func decorate(with style: FooterStyle) {
        if let termsText = style.termsOfUseText {
            termsLabel.text = termsText
        }

        if let privacyText = style.privacyPolicyText {
            privacyLabel.text = privacyText
        }

        if let restorePurchaseText = style.restorePurchaseText {
            restorePurchaseButton.setTitle(restorePurchaseText, for: .normal)
        }
        
        if let termsLabelStyle = style.termsLabelStyle {
            termsLabel.decorate(with: termsLabelStyle)
        }
        
        if let privacyPolicyLabelStyle = style.privacyPolicyLabelStyle {
            privacyLabel.decorate(with: privacyPolicyLabelStyle)
        }
        
        if let restorePurchaseButtonStyle = style.restorePurchaseButtonStyle {
            restorePurchaseButton.decorate(with: restorePurchaseButtonStyle)
        }
    }
    
    private func setupStackView() {
        let stackView = UIStackView(arrangedSubviews: [termsLabel,
                                                       privacyLabel,
                                                       restorePurchaseButton])
        stackView.axis = .horizontal
        stackView.spacing = 16
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
