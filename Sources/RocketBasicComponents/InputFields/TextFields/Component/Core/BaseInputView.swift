//
//  File.swift
//
//
//  Created by Alexandr Mefisto on 02.08.2023.
//

import UIKit
import Foundation
import Combine
import Styling
import LayoutKit

open class BaseInputView: NiblessView {
    
    // MARK: - Constants
    enum BaseInputViewConstants {
        static let errorLabelHeight: CGFloat = 77
        static let noErrorLabelHeight: CGFloat = 64
        static let initialHeight: CGFloat = 64
        static let topLabelHeight: CGFloat = 18
        static let fieldHeight: CGFloat = 44
        static let leadingOffset: CGFloat = 16
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
    
    var type: InputFieldType = .email
    
    let errorLabel = Label(text: "",
                                   textColor: .red,
                           font: .systemFont(ofSize: 10),
                                   alignment: .left)
    let topLabel = Label(text: "",
                                 textColor: UIColor.black.withAlphaComponent(0.4),
                         font: .systemFont(ofSize: 10),
                                 alignment: .left)
    var baseIntputView = UIView(frame: .zero)
    
    var topLabelColor: UIColor = .black
    var textColor: UIColor = .black
    
    var heightConstraint: NSLayoutConstraint?
    
    // MARK: Initializers
    
    public init(type: InputFieldType,
                textColor: UIColor = .black,
                topLabelColor: UIColor = UIColor.black.withAlphaComponent(0.4),
                nextInput: TextFieldView? = nil) {
        super.init(frame: .zero)
        
        errorLabel.isHidden = true
        isUserInteractionEnabled = true
        self.topLabelColor = topLabelColor
        self.textColor = textColor
        
        self.type = type
        setup(with: type, nextInput: nextInput)
        setup()
    }
    
    func setup() {
        topLabel.text = type.topLabel
        topLabel.textColor = topLabelColor
        setupConstraints()
    }
    
    func setup(with type: InputFieldType, nextInput: TextFieldView? = nil) {
        configureTextField(with: type)
    }
    
    func configureTextField(with type: InputFieldType) {
        
    }
    
    func setupHierarchy() {
        addSubview(topLabel)
        insertSubview(errorLabel, belowSubview: baseIntputView)
    }
    
    func setupConstraints() {
        setupHierarchy()
        addSubview(baseIntputView)
        
        makeConstraints { make in
            heightConstraint = make.height.equalTo(BaseInputViewConstants.initialHeight)
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
            make.bottom.lessThanOrEqualTo(bottomAnchor)
        }
        
        errorLabel.makeConstraints { make in
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
        case .error(let errorMessage, let delta):
            let isErrorLabelHidden = errorLabel.isHidden
            crossfadeErrorLabel(to: errorMessage, duration: animated ? 0.1 : 0)
            if isErrorLabelHidden {
                errorLabel.isHidden = false
                heightConstraint?.constant = BaseInputViewConstants.errorLabelHeight
                delegate?.textFieldView(self, didChangeHeight: delta, animated: animated)
            }
        case .noError(let delta):
            errorLabel.isHidden = true
            heightConstraint?.constant = BaseInputViewConstants.noErrorLabelHeight
            delegate?.textFieldView(self, didChangeHeight: delta, animated: animated)
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
            showError(.noError(delta: -BaseInputViewConstants.errorDelta))
        case .failure(let error):
            showError(.error(message: error.description, delta: BaseInputViewConstants.errorDelta))
        }
    }
}

public extension BaseInputView {
    func createTextAndEditingStatePublisher() -> (textPublisher: AnyPublisher<String?, Never>, editingStatePublisher: AnyPublisher<Void, Never>) {
        let textPublisher = self.textDidChangePublisher.eraseToAnyPublisher()
        let editingStatePublisher = self.didEndEditingPublisher.eraseToAnyPublisher()
        return (textPublisher, editingStatePublisher)
    }
}
