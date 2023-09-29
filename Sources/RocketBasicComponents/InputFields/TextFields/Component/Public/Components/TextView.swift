import UIKit
import Combine

open class TextView: BaseInputView {
    
    private let inputTextView = UITextView()
    open var isPlaceholder = true
    
    override open var value: String {
        isPlaceholder ? "" : inputTextView.text
    }
    
    private var placeholder: String?

    private let textDidChangeSubject = PassthroughSubject<String?, Never>()
    private let didEndEditingSubject = PassthroughSubject<Void, Never>()
    
    public func setPlaceholder(_ placeholder: String) {
        self.placeholder = placeholder
        inputTextView.text = placeholder
        inputTextView.textColor = currentStyle?.placeholderTextColor?.color
    }
    
    override func setup() {
        setupTextView(nil)
        super.setup()
        textDidChangePublisher = textDidChangeSubject.eraseToAnyPublisher()
        didEndEditingPublisher = didEndEditingSubject.eraseToAnyPublisher()
        setPlaceholder(config?.placeholder ?? "")
    }
    
    open override func decorate(with style: InputFieldStyle) {
        super.decorate(with: style)
        self.currentStyle = style
        setupTextView(style)
        if placeholder != nil { return }
        inputTextView.textColor = style.textColor?.color
    }
    
    override func setupConstraints() {
        setupHierarchy()
        addSubview(baseIntputView)
        
        makeConstraints { make in
            heightConstraint = make.height.greaterThanOrEqualTo(BaseInputViewConstants.initialHeight)
        }
        
        topLabel.makeConstraints { make in
            make.height.greaterThanOrEqualTo(BaseInputViewConstants.topLabelHeight)
            make.leading.equalToSuperview().offset(BaseInputViewConstants.leadingOffset)
            make.top.equalTo(topAnchor)
        }
        
        baseIntputView.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalTo(topLabel.bottomAnchor).offset(2)
            make.height.greaterThanOrEqualTo(BaseInputViewConstants.fieldHeight)
        }
        
        errorLabel.makeConstraints { make in
            make.top.equalTo(baseIntputView.bottomAnchor)
            make.leading.equalTo(topLabel.leadingAnchor)
            make.trailing.equalToSuperview()
            make.bottom.equalTo(bottomAnchor)
        }
    }
    
    open func setupTextView(_ style: InputFieldStyle?) {
        inputTextView.delegate = self
        inputTextView.textContainerInset = .init(top: 10, left: 10, bottom: 10, right: 10)
        if let font = style?.fontProfile {
            inputTextView.applyTypography(font)
        } else {
            inputTextView.font =  UIFont.systemFont(ofSize: 17)
        }
        inputTextView.layer.borderWidth = style?.borderWidth ?? 1
        inputTextView.layer.borderColor = style?.borderColor?.color.cgColor ?? UIColor.black.withAlphaComponent(0.5).cgColor
        inputTextView.layer.cornerRadius = style?.effect?.cornerRadius ?? 4
        inputTextView.sizeToFit()
        inputTextView.spellCheckingType = .no
        inputTextView.isScrollEnabled = false
        inputTextView.selectedTextRange =  inputTextView.textRange(from: inputTextView.beginningOfDocument,
                                                                   to: inputTextView.beginningOfDocument)
        inputTextView.backgroundColor = style?.backgroundColor?.color ?? .clear
        baseIntputView = inputTextView
        baseIntputView.makeConstraints { make in
            make.height.greaterThanOrEqualTo(style?.height ?? 120)
        }
    }
}

extension TextView: UITextViewDelegate {
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let currentText = textView.text as? NSString ?? NSString(string: "")
        let updatedText = currentText.replacingCharacters(in: range, with: text)
        
        if updatedText.isEmpty {
            isPlaceholder = true
            textView.text = placeholder
            textView.textColor = currentStyle?.placeholderTextColor?.color
            textDidChangeSubject.send(updatedText)
            return false
        } else if isPlaceholder && !text.isEmpty {
            isPlaceholder = false
            textView.text = nil
            textView.textColor = currentStyle?.textColor?.color
            textDidChangeSubject.send(updatedText)
        }
        textDidChangeSubject.send(updatedText)
        return true
    }
    
    public func textViewDidEndEditing(_ textView: UITextView) {
        didEndEditingSubject.send(())
    }
    
    public func textViewDidChangeSelection(_ textView: UITextView) {
        if isPlaceholder {
            textView.selectedTextRange = inputTextView.textRange(from: inputTextView.beginningOfDocument, to: inputTextView.beginningOfDocument)
        }
    }
}
