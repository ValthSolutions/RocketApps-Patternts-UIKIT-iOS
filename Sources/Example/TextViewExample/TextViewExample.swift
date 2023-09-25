import UIKit
import RocketComponents
import Combine

public extension Validator {
    static var notEmpty: Validator {
        return Validator { value in
            return !value.isEmpty ? .success : .failure(DefaultValidationError.emptyValue)
        }
    }
}

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
            rootView.noteTextView: RootView.customConfiguration.validationChain
        ]
        
        let validator = ValidationHolder(baseInputViews: [rootView.noteTextView,
                                                          rootView.noteTextView],
                                         validationChains: validationChains)
        validator.bindValidationPublishers(to: rootView)
    }
}

final class RootView: NiblessView, IValidationForm {
    var cancellables = Set<AnyCancellable>()
    
    private(set) lazy var noteTextView = TextView(config: RootView.customConfiguration)

    static let customConfiguration = TextFieldConfiguration(
        placeholder: "Custom Placeholder",
        topLabel: "Custom Label",
        keyboardType: .default,
        validationChain: ValidationChain(validators: [Validator.notEmpty],
                                         validationError: DefaultValidationError.emptyValue)
    )

    init() {
        super.init(frame: .zero)
        setupUI()
        noteTextView.decorate(with: .init(height: nil))
        noteTextView.setPlaceholder("HELO World")
    }
    
    func updateUIWithFiredPublisher(isEnabled: Bool) {

    }
}

// MARK: - Hierarchy

extension RootView {
    private func setupHierarchy() {
        addSubview(noteTextView)
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
        noteTextView.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.topAnchor).offset(16)
            make.leading.equalTo(leadingAnchor).offset(16)
            make.trailing.equalTo(trailingAnchor).offset(-16)
        }
    }
}
