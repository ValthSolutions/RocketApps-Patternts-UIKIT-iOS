import UIKit
import Combine

public protocol IValidationForm: UIView {
    var cancellables: Set<AnyCancellable> { get set }
    func bindValidationPublisher(_ publisher: AnyPublisher<ValidationResult, Never>,
                                 to baseInputView: BaseInputView)
    func createEnabledPublishers(_ validationPublishers: [AnyPublisher<ValidationResult,
                                                          Never>]) -> AnyPublisher<Bool, Never>
    func updateUIWithEnabledPublisher(_ enabledPublisher: AnyPublisher<Bool, Never>, onEnabledStateChange: @escaping (Bool) -> Void)
    func updateUIWithFiredPublisher(isEnabled: Bool)
}

public extension IValidationForm {
    func bindValidationPublisher(_ publisher: AnyPublisher<ValidationResult, Never>, to baseInputView: BaseInputView) {
        publisher
            .receive(on: DispatchQueue.main)
            .sink { validationResult in
                baseInputView.applyValidationResult(validationResult)
                baseInputView.isValid = validationResult.isValid
            }
            .store(in: &cancellables)
    }
    
    func createEnabledPublishers(_ validationPublishers: [AnyPublisher<ValidationResult, Never>]) -> AnyPublisher<Bool, Never> {
        guard !validationPublishers.isEmpty else {
            return Just(false).eraseToAnyPublisher()
        }
        
        return validationPublishers.combineLatestMany()
            .map { validationResults in
                return validationResults.allSatisfy { validationResult in
                    switch validationResult {
                    case .success:
                        return true
                    case .failure:
                        return false
                    }
                }
            }
            .eraseToAnyPublisher()
    }
    
    func updateUIWithEnabledPublisher(_ enabledPublisher: AnyPublisher<Bool, Never>, onEnabledStateChange: @escaping (Bool) -> Void) {
        enabledPublisher
            .sink { isEnabled in
                onEnabledStateChange(isEnabled)
            }
            .store(in: &cancellables)
    }
}
