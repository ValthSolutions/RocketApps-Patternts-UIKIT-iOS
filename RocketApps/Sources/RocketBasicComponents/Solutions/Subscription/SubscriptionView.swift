import UIKit

public protocol LinkHandler: AnyObject {
    func handleLink(_ url: URL)
}

open class RegistrationFooterView: NiblessView {
    
    public var fontSize: CGFloat = 14
    private var textColor: UIColor
    private let textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .center
        textView.backgroundColor = .clear
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.textContainerInset = .zero
        textView.textContainer.lineFragmentPadding = 0
        return textView
    }()
    
    public weak var linkHandler: LinkHandler?
    
    public init(textColor: UIColor = .white) {
        self.textColor = textColor
        super.init(frame: .zero)
        setup()
    }
    
    open func setup() {
        addSubview(textView)
        setupConstraints()
        observeLanguageChange()
        setupTitles()
        backgroundColor = .clear
        textView.delegate = self
    }
    
    open override func setupTitles() {
        setupAttributedString()
        backgroundColor = .clear
    }
    
    private func setupAttributedString() {
        guard let termsURL = URL(string: "https://policies.google.com/terms?hl=en-US"),
              let policyURL = URL(string: "https://policies.google.com/privacy?hl=en-US") else { return }
        let termsOfUseURL = termsURL
        let privacyPolicyURL = policyURL
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        guard let font = R.font.sfProTextRegular(size: fontSize) else { return }
        
        let regularAttributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .paragraphStyle: paragraphStyle,
            .foregroundColor: textColor.withAlphaComponent(0.6)
        ]
        
        guard let font = R.font.sfProTextRegular(size: fontSize) else { return }
        let linkAttributes: (URL) -> [NSAttributedString.Key: Any] = { url in
            [
                .paragraphStyle: paragraphStyle,
                .link: url,
                .underlineStyle: NSUnderlineStyle.single.rawValue,
                .foregroundColor: self.textColor,
                .font: font
            ]
        }
        let attributedString = NSMutableAttributedString(string: "Terms", attributes: regularAttributes)
        attributedString.append(NSAttributedString(string: "sss"), attributes: linkAttributes(termsOfUseURL)))
        attributedString.append(NSAttributedString(string: "saf"), attributes: regularAttributes))
        attributedString.append(NSAttributedString(string: "savac"), attributes: linkAttributes(privacyPolicyURL)))
        textView.attributedText = attributedString
        textView.tintColor = textColor.withAlphaComponent(0.6)
    }
    
    private func setupConstraints() {
        textView.setEdges()
    }
}

// MARK: - UITextViewDelegate

extension RegistrationFooterView: UITextViewDelegate {
    public func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        linkHandler?.handleLink(URL)
        return false
    }
}
