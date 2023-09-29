//
//  ViewController.swift
//  Texs
//
//  Created by LEMIN DAHOVICH on 19.09.2023.
//

import UIKit
import RocketComponents

// Create a extension to a Validator to define a validation RULE
public extension Validator {
    static var notEmpty: Validator {
        return Validator { value in
            return !value.isEmpty ? .success : .failure(DefaultValidationError.emptyValue)
        }
    }
}

// MARK: - VC

class ViewController: UIViewController {
    
    let rootView = RootView()
    
    override func loadView() {
        super.loadView()
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindAndValidateInputs()
    }
    
    private func bindAndValidateInputs() {
        
        let validationChains = [
            rootView.newPasswordTextFieldView: RootView.emailConfiguration.validationChain,
            rootView.confirmPasswordTextFieldView: RootView.customConfiguration.validationChain
        ]
        
        let validator = ValidationHolder(baseInputViews: [rootView.newPasswordTextFieldView,
                                                      rootView.confirmPasswordTextFieldView],
                                         validationChains: validationChains)
        validator.bindValidationPublishers(to: rootView)
    }
}

// MARK: - Root view

final class RootView: NiblessView, IValidationForm {
    var cancellables = Set<AnyCancellable>()
    
    public var allFields: [TextFieldView] { [newPasswordTextFieldView,
                                             confirmPasswordTextFieldView] }

    private(set) var newPasswordTextFieldView = TextFieldView(config: TextFieldConfiguration(placeholder: "Hi",
                                                                                             topLabel: "safasf"))
    private(set) var confirmPasswordTextFieldView = TextFieldView(config: TextFieldConfiguration(placeholder: "Hi",
                                                                                                 topLabel: "safasf"))
    
    private(set) lazy var fieldStackView = ExpandableStackView(textFields: allFields)

    init() {
        super.init(frame: .zero)
        setupUI()
        allFields.forEach { $0.decorate(with: .init(height: nil))}
    }
    
    func updateUIWithFiredPublisher(isEnabled: Bool) {
        // get %('allFields') True|False from validation system
    }
}

// MARK: - Hierarchy

extension RootView {
    private func setupHierarchy() {
        let views = []
        addSubviews(fieldStackView)
    }
    
    private func setupUI() {
        backgroundColor = .white
        setupHierarchy()
        setupConstraints()
    }
}

// MARK: - Constraints

extension RootView {
    private func setupConstraints() {
        fieldStackView.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.topAnchor).offset(16)
            make.leading.equalTo(leadingAnchor).offset(16)
            make.trailing.equalTo(trailingAnchor).offset(-16)
        }
    }
}
