
import UIKit
import Styling
import LayoutKit

open class BaseInputView: NiblessView {
    
    // MARK: - Constants
    enum BaseInputViewConstants {
        static let errorLabelHeight: CGFloat = 77
        static let initialHeight: CGFloat = 64
        static let topLabelHeight: CGFloat = 18
        static let fieldHeight: CGFloat = 44
        static let leadingOffset: CGFloat = 16
        static let errorDelta: CGFloat = 13
    }
    
    public var isValid: Bool = true
    
    // MARK: - Properties and UI elements
    public var value: String { "" }
    
    public var nextInput: UIResponder?
    
    let errorLabel = BaseLabel()
    let topLabel = BaseLabel()
    
    var baseIntputView = UIView(frame: .zero)
    var configuration: TextFieldConfiguration!
    
    var topLabelColor: UIColor = .black
    var textColor: UIColor = .black
    
    // MARK: Initializers
    
    public init(configuration: TextFieldConfiguration,
                nextInput: TextFieldView? = nil) {
        super.init(frame: .zero)
        
        self.configuration = configuration
        
        errorLabel.isHidden = true
        isUserInteractionEnabled = true
        setup()
    }
    
    func setup() {
        topLabel.text = configuration.topLabel
        topLabel.textColor = topLabelColor
        setupConstraints()
    }
    
    func setupHierarchy() {
        addSubview(topLabel)
        insertSubview(errorLabel, belowSubview: baseIntputView)
    }
    
    func setupConstraints() {
        setupHierarchy()
        addSubview(baseIntputView)
        
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
            make.bottom.lessThanOrEqualTo(bottomAnchor)
        }
        
        errorLabel.makeConstraints { make in
            make.top.equalTo(baseIntputView.topAnchor).offset(10)
            make.leading.equalTo(topLabel.leadingAnchor)
            make.trailing.equalToSuperview()
            make.bottom.equalTo(bottomAnchor)
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
    
    public func showError(_ state: ErrorState, animated: Bool = true) {
        switch state {
        case .error(let errorMessage):
            let isErrorLabelHidden = errorLabel.isHidden
            crossfadeErrorLabel(to: errorMessage, duration: animated ? 0.1 : 0)
            if isErrorLabelHidden {
                errorLabel.isHidden = false
            }
        case .noError:
            errorLabel.isHidden = true
        }
        
        if animated {
            UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut) {
                self.layoutIfNeeded()
            }
        } else {
            layoutIfNeeded()
        }
    }
}
// MARK: - Validation Adapter

extension BaseInputView: ValidationResultAdapter {
    public typealias ErrorType = ValidationErrorConvertible
    
    public func applyValidationResult(_ validationResult: ValidationResult<ErrorType>) {
        switch validationResult {
        case .success:
            showError(.noError)
        case .failure(let error):
            showError(.error(message: error.errorDescription))
        }
    }
}
