import UIKit
import Foundation
import Combine
import Styling

open class TextFieldView: BaseInputView {
    
    enum Constants {
        static let textFieldContentHuggingPriority: Float = 249
    }
    
    // MARK: - Properties and UI elements
    
    open override var value: String {
        return inputTextField.text ?? ""
    }
    
    open override var isValid: Bool {
        didSet {
            inputTextField.isValid = isValid
        }
    }
    
    open override var nextInput: UIResponder? {
        didSet {
            inputTextField.returnKeyType = nextInput == nil ? .done : .next
        }
    }
    
    open lazy var inputTextField: TextField = {
        let textField = TextField()
        return textField
    }()
    
    private var cancellables = Set<AnyCancellable>()
    private let imageView = UIImageView()
    
    // MARK: Initializers
    
    public override init(config: TextFieldConfiguration?,
                         nextInput: TextFieldView? = nil) {
        super.init(config: config,
                   nextInput: nextInput)
    }
    
    open override func decorate(with style: InputFieldStyle) {
        super.decorate(with: style)
        inputTextField.decorate(with: style)
    }
    
    override func setup() {
        super.setup()
        setupUI()
        
        textDidChangePublisher = inputTextField.textDidChangePublisher
        didEndEditingPublisher = inputTextField.didEndEditingSubject.eraseToAnyPublisher()
    }
    
    override func setup(with config: TextFieldConfiguration,
                        nextInput: TextFieldView? = nil) {
        configureTextField(with: config)
        self.type = config
        self.nextInput = nextInput?.inputTextField
    }
    
    override func configureTextField(with config: TextFieldConfiguration) {
        defaultSetup(config)
    }
    
    private func setupUI() {
        setupInputTextField()
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapOnField)))
    }
}

// MARK: - Actions

private extension TextFieldView {
    @objc func didTapOnField() {
        inputTextField.becomeFirstResponder()
    }
}

// MARK: - Private

extension TextFieldView {
    private func setupInputTextField() {
        inputTextField.setContentHuggingPriority(UILayoutPriority(Constants.textFieldContentHuggingPriority),
                                                 for: .horizontal)
        let font: UIFont = .systemFont(ofSize: 10)
        inputTextField.font = font
        inputTextField.normalTextColor = textColor
        inputTextField.tintColor = .gray
        inputTextField.rightViewMode = .always
        inputTextField.nextDelegate = self
    }
    
    // MARK: - Pickers Setup
    
    private func defaultSetup(_ config: TextFieldConfiguration) {
        inputTextField.setPlaceholder(config.placeholder, color: textColor)
        topLabel.text = config.topLabel
        inputTextField.isSecureTextEntry = config.needEyeSecure
        inputTextField.autocapitalizationType = config.autocapitalizationType
        inputTextField.keyboardType = config.keyboardType
        inputTextField.textContentType = config.contentType
        inputTextField.rightViewMode = config.needEyeSecure ? .always : .never
        baseIntputView = inputTextField
    }
}
