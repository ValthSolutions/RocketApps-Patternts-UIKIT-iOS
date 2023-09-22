import Combine
import Foundation

open class ValidationHolder {
    
    // MARK: Properties
    
    let baseInputViews: [BaseInputView]
    let validationChains: [BaseInputView: ValidationChain]
    
    public typealias ValidationFunction = (AnyPublisher<(String?, Void), Never>) -> AnyPublisher<ValidationResult, Never>
    
    // MARK: - Init
    
    public init(baseInputViews: [BaseInputView],
                validationChains: [BaseInputView: ValidationChain]) {
        self.baseInputViews = baseInputViews
        self.validationChains = validationChains
    }
}

// MARK: - Public

extension ValidationHolder {
    public func createValidationPublisher(_ combinedPublisher: AnyPublisher<(String?, Void), Never>,
                                          validator: @escaping (String) -> ValidationResult) -> AnyPublisher<ValidationResult, Never> {
        combinedPublisher
            .receive(on: DispatchQueue.main)
            .debounce(for: .milliseconds(150), scheduler: DispatchQueue.main)
            .map { (text, _) in
                validator(text ?? "")
            }
            .eraseToAnyPublisher()
    }
    
    public func bindValidationPublishers(to rootView: IValidationForm) {
        var validationPublishers: [AnyPublisher<ValidationResult, Never>] = []
        let fieldViewToValidationFunction = buildFieldViewToValidationFunction()
        
        for (baseInputView, validationFunction) in fieldViewToValidationFunction {
            
            let (textPublisher, editingStatePublisher) = baseInputView.createTextAndEditingStatePublisher()
            let validationPublisher = validationFunction(
                textPublisher.combineLatest(editingStatePublisher)
                    .map { ($0, $1) }
                    .eraseToAnyPublisher()
            )
            rootView.bindValidationPublisher(validationPublisher, to: baseInputView)
            validationPublishers.append(validationPublisher)
        }
        
        let enabledPublisher = rootView.createEnabledPublishers(validationPublishers)
        rootView.updateUIWithEnabledPublisher(enabledPublisher) { isEnabled in
            rootView.updateUIWithFiredPublisher(isEnabled: isEnabled)
        }
    }
}

// MARK: - Private

extension ValidationHolder {
    private func buildFieldViewToValidationFunction() -> [BaseInputView: ValidationFunction] {
        return validationChains.mapValues { validationChain in { combinedPublisher in
            self.createValidationPublisher(combinedPublisher, validator: validationChain.validate)
        }
        }
    }
}
