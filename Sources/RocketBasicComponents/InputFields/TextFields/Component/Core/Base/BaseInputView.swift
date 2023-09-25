import UIKit
import Foundation
import Combine
import Styling
import LayoutKit

open class BaseInputView: NiblessView {
    
    // MARK: - Constants
    enum BaseInputViewConstants {
        static let initialHeight: CGFloat = 77
        static let topLabelHeight: CGFloat = 18
        static let fieldHeight: CGFloat = 44
        static let leadingOffset: CGFloat = 8
        static let topLabelLeadingOffset: CGFloat = 0
        static let errorDelta: CGFloat = 13
    }
    // MARK: - Validation Publishers
    public var textDidChangePublisher: AnyPublisher<String?, Never>!
    public var didEndEditingPublisher: AnyPublisher<Void, Never>!

    public var isValid: Bool = true
    
    // MARK: - Properties and UI elements
    public var value: String { "" }
    public weak var delegate: BaseInputViewDelegate?

    public var nextInput: UIResponder?
    
    var type: TextFieldConfiguration?
    
    let errorLabel: BaseLabel = .init()
    let topLabel: BaseLabel = .init()
    
    var baseIntputView = UIView(frame: .zero)
    
    var topLabelColor: UIColor = .black
    var textColor: UIColor = .black
    var currentStyle: TextViewStyle?
    var heightConstraint: NSLayoutConstraint?

    // MARK: Initializers
    
    public init(config: TextFieldConfiguration,
                nextInput: TextFieldView? = nil) {
        
        super.init(frame: .zero)
        
        errorLabel.isHidden = true
        isUserInteractionEnabled = true

        self.type = config
        setup(with: config, nextInput: nextInput)
        setup()
    }
    
    func setup() {
        topLabel.text = type?.topLabel ?? ""
        errorLabel.text = type?.topLabel ?? ""
        setupConstraints()
    }
    
    func setup(with type: TextFieldConfiguration,
               nextInput: TextFieldView? = nil) {
        configureTextField(with: type)
    }
    
    func configureTextField(with type: TextFieldConfiguration) {
        
    }
    
    func setupHierarchy() {
        addSubview(topLabel)
        insertSubview(errorLabel, belowSubview: baseIntputView)
    }
    
    func setupConstraints() {
        setupHierarchy()
        addSubview(baseIntputView)
        
        makeConstraints { make in
            heightConstraint = make.height.equalTo(
                BaseInputViewConstants.initialHeight
            )
        }
        
        topLabel.makeConstraints { make in
            make.height.greaterThanOrEqualTo(BaseInputViewConstants.topLabelHeight)
            make.leading.equalToSuperview().offset(BaseInputViewConstants.topLabelLeadingOffset)
            make.top.equalTo(topAnchor).offset(-4)
        }
        
        baseIntputView.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalTo(topLabel.bottomAnchor).offset(2)
            make.height.greaterThanOrEqualTo(BaseInputViewConstants.fieldHeight)
            make.bottom.lessThanOrEqualTo(bottomAnchor)
        }
        
        errorLabel.makeConstraints { make in
            make.leading.equalToSuperview().offset(BaseInputViewConstants.leadingOffset)
            make.trailing.equalToSuperview()
            make.bottom.equalTo(bottomAnchor)
        }
    }
}

// MARK: - Decorator
extension BaseInputView: Decoratable {
    public typealias Style = TextViewStyle
    
    public func decorate(with style: TextViewStyle) {
        setup()
        self.currentStyle = style
        self.topLabelColor = style.topLabelColor?.color ?? .black
        self.textColor = style.textColor?.color ?? .black
        if let topStyle = style.topLabelStyle {
            self.topLabel.decorate(with: topStyle)
        }
        if let errorStyle = style.errorLabelStyle {
            self.errorLabel.decorate(with: errorStyle)
        }
    }
}

// MARK: - Errors

extension BaseInputView {
    func crossfadeErrorLabel(to newMessage: String?, duration: TimeInterval) {
        let transition = CATransition()
        transition.type = .fade
        transition.duration = duration
        errorLabel.layer.add(transition, forKey: "textChange")
        errorLabel.text = newMessage
    }
    
    public func showError(_ state: ErrorState) {
        switch state {
        case .error(let errorMessage):
            if let style = currentStyle {
                decorate(with: style)
            }
            let isErrorLabelHidden = errorLabel.isHidden
            crossfadeErrorLabel(to: errorMessage,
                                duration: 0.1)
            if isErrorLabelHidden {
                errorLabel.isHidden = false
            }
        case .noError:
            errorLabel.isHidden = true
        }
    }
}

public extension BaseInputView {
    func createTextAndEditingStatePublisher() -> (textPublisher: AnyPublisher<String?, Never>, editingStatePublisher: AnyPublisher<Void, Never>) {
        let textPublisher = self.textDidChangePublisher
            .eraseToAnyPublisher()
        let editingStatePublisher = self.didEndEditingPublisher
            .eraseToAnyPublisher()
        return (textPublisher, editingStatePublisher)
    }
}


// MARK: - TextFieldNextDelegate

extension BaseInputView: TextFieldNextDelegate {
    public func textFieldShouldReturn(_ textField: TextField) -> Bool {
        if let next: UIResponder = nextInput {
            next.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
}

// MARK: - Validation Adapter

extension BaseInputView: ValidationResultAdapter {
    public func applyValidationResult(_ validationResult: ValidationResult) {
        switch validationResult {
        case .success:
            showError(.noError)
        case .failure(let error):
            showError(.error(message: error.description))
        }
    }
}
