import UIKit
import Foundation
import Combine

public final class TextFieldView: BaseInputView {
    
    // MARK: - Constants
    enum Constants {
        static let errorLabelHeight: CGFloat = 77
        static let noErrorLabelHeight: CGFloat = 64
        static let initialHeight: CGFloat = 64
        static let eyeButtonSize: CGSize = CGSize(width: 24, height: 24)
        static let textFieldContentHuggingPriority: Float = 249
        static let textFieldFontSize: CGFloat = 17
        static let topLabelHeight: CGFloat = 18
        static let fieldHeight: CGFloat = 44
        static let leadingOffset: CGFloat = 16
        static let errorDelta: CGFloat = 13
        static let noteHeight: CGFloat = 120
        static let noteInitialHeight: CGFloat = 140
        static let policyNumberMaxLenght: Int = 13
    }
    
    // MARK: - Properties and UI elements
    
    public var phoneCode: String?
    public override var value: String {
            return inputTextField.text ?? ""
    }
    
    public override var isValid: Bool {
        didSet {
            inputTextField.isValid = isValid
        }
    }
    
    public override var nextInput: UIResponder? {
        didSet {
            inputTextField.returnKeyType = nextInput == nil ? .done : .next
        }
    }
    
    public weak var delegateDidSelect: TextFieldViewDidSelectDelegate?
    public weak var buttonDelegate: TextFieldViewButtonDelegate?
    
    public lazy var inputTextField: TextField = {
        let textField = TextField()
        return textField
    }()
    
    private var cancellables = Set<AnyCancellable>()
    private let emailImageView = UIImageView()
    
    // MARK: Initializers
    
    override func setup() {
        super.setup()
        setupUI()
        
        textDidChangePublisher = inputTextField.textDidChangePublisher
        didEndEditingPublisher = inputTextField.didEndEditingSubject.eraseToAnyPublisher()
    }
    
    override func setup(with type: TextFieldConfiguration, nextInput: TextFieldView? = nil) {
        configureTextField(with: type)
        self.type = type
        self.nextInput = nextInput?.inputTextField
    }
    
    override func configureTextField(with type: TextFieldConfiguration) {
        defaultSetup(type)
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
    
    private func defaultSetup(_ type: TextFieldConfiguration) {
        inputTextField.setPlaceholder(type.placeholder, color: textColor)
        topLabel.text = type.topLabel
        inputTextField.isSecureTextEntry = type.needEyeSecure
        inputTextField.autocapitalizationType = type.autocapitalizationType
        inputTextField.keyboardType = type.keyboardType
        inputTextField.textContentType = type.contentType
        inputTextField.rightViewMode = type.needEyeSecure ? .always : .never
        baseIntputView = inputTextField
    }
}
