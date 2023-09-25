import Foundation

public struct Validator {

    private let closure: (String) -> ValidationResult
    
    public init(validation: @escaping (String) -> ValidationResult) {
        self.closure = validation
    }
    
    public func validate(value: String) -> ValidationResult {
        return closure(value)
    }
}

extension Validator {
    private enum Constants {
        static var phoneNumberWithoutCodeBottom = 9
        static var phoneNumberWithoutCodeTop = 20
        static var registrationIDStarts: String { "CHE" }
        static var numbers: String { "0123456789" }
        static var numbersCount: Int { 9 }
        static var totalCount: Int { 12 }
        static var totalCountWithSymbols: Int { 15 }
        static var plus: String { "+" }
        static var space: String { " " }
        static var nonVisibleSymbols: String { " " }
        static var cityLenghtFrom: Int { 1 }
        static var cityLenghtTo: Int { 50 }
        static var addressLenghtFrom: Int { 1 }
        static var addressLenghtTo: Int { 250 }
        static var policyNumberLenghtFrom: Int { 5 }
        static var policyNumberLenghtTo: Int { 13 }
    }
}
