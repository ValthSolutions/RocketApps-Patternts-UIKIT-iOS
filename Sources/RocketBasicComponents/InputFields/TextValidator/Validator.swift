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

public extension Validator {
    
//    static var startsWithUppercase: Validator {
//        return Validator { value in
//            guard let firstCharacter = value.first else {
//                return .failure(ValidationError.emptyValue)
//            }
//            return firstCharacter.isUppercase ? .success : .failure(ValidationError.startsWithUppercaseError)
//        }
//    }
//    
//    static var maxLenght: Validator {
//        return Validator { value in
//            return (value.count <= 300 && value.count > 5) ? .success : .failure(ValidationError.lengthError)
//        }
//    }
//
//    static var lastName: Validator {
//        return Validator { value in
//            let letterCount = value.filter { $0.isLetter }.count
//            return (letterCount >= 2 && value.count <= 70) ? .success : .failure(ValidationError.hasTwoTo70Symbols)
//        }
//    }
//    
//    static var phoneNumber: Validator {
//        return Validator { value in
//            var phoneNumber = value
//            phoneNumber.removeAll { String($0) == Constants.space }
//            return (phoneNumber.count >= Constants.phoneNumberWithoutCodeBottom && phoneNumber.count <= Constants.phoneNumberWithoutCodeTop) ? .success : .failure(ValidationError.phoneInvalid)
//        }
//    }
//    
//    static var resetPasswordPhoneNumber: Validator {
//        return Validator { value in
//            guard !value.isEmpty else { return .failure(ValidationError.phoneInvalid) }
//           
//            var phoneNumber = value
//            let isFirstPlus = String(phoneNumber.removeFirst()) == Constants.plus
//            
//            phoneNumber.removeAll { String($0) == Constants.space }
//            let isAllNumbers = phoneNumber.filter { $0.isNumber }.count == phoneNumber.count
//            
//            if !isAllNumbers || !isFirstPlus {
//                return .failure(ValidationError.phoneInvalid)
//            }
//            
//            return (phoneNumber.count >= Constants.phoneNumberWithoutCodeBottom && phoneNumber.count <= Constants.phoneNumberWithoutCodeTop) ? .success : .failure(ValidationError.phoneInvalid)
//        }
//    }
    
    static var notEmpty: Validator {
        return Validator { value in
            return !value.isEmpty ? .success : .failure(ValidationError.emptyValue)
        }
    }
//
//    static var text: Validator {
//        return Validator { value in
//            return (value.count <= 255 && value.count > 0) ? .success : .failure(ValidationError.emptyValue)
//        }
//    }
//
//    static var email: Validator {
//        return Validator { value in
//            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,5}"
//            let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
//            return emailTest.evaluate(with: value) ? .success : .failure(ValidationError.emailInvalid)
//        }
//    }
//
//    static var passwordLength: Validator {
//        return Validator { value in
//            return (value.count >= 8 && value.count <= 16) ? .success : .failure(ValidationError.lengthError)
//        }
//    }
//
//    static var passwordNumber: Validator {
//        return Validator { value in
//            return value.rangeOfCharacter(from: CharacterSet.decimalDigits) != nil ? .success : .failure(ValidationError.numberError)
//        }
//    }
//
//    static var passwordSpecialSymbol: Validator {
//        return Validator { value in
//            return value.rangeOfCharacter(from: CharacterSet(charactersIn: "!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~")) != nil ? .success : .failure(ValidationError.specialSymbolError)
//        }
//    }
//
//    static var addessLenght: Validator {
//        return Validator { value in
//            let valueVithoutNonPrint = value.filter { !$0.isWhitespace }
//            return (valueVithoutNonPrint.count >= Constants.addressLenghtFrom &&
//                    valueVithoutNonPrint.count <= Constants.addressLenghtTo) ? .success : .failure(ValidationError.gentralLenghtError(from: Constants.addressLenghtFrom,
//                                                                    to: Constants.addressLenghtTo))
//        }
//    }
//
//    static var postalCodeLenght: Validator {
//        return Validator { value in
//            return (value.count >= 4 && value.count <= 10) ? .success : .failure(ValidationError.formatValidationError)
//        }
//    }
//
//    static var postalCodeNumbers: Validator {
//        return Validator { value in
//            return (value.allSatisfy { $0.isNumber }) ? .success : .failure(ValidationError.formatValidationError)
//        }
//    }
//
//    static var cityLenght: Validator {
//        return Validator { value in
//            let valueVithoutNonPrint = value.filter { !$0.isWhitespace }
//            return (valueVithoutNonPrint.count >= Constants.cityLenghtFrom &&
//                    valueVithoutNonPrint.count <= Constants.cityLenghtTo) ? .success : .failure(ValidationError.gentralLenghtError(from: Constants.cityLenghtFrom,
//                                                                    to: Constants.cityLenghtTo))
//        }
//    }
//
//    static var insurancePolicyNumberFormat: Validator {
//        return Validator { value in
//            return (value.allSatisfy { $0.isNumber }) ? .success : .failure(ValidationError.formatValidationError)
//        }
//    }
//
//    static var insurancePolicyNumberLenght: Validator {
//        return Validator { value in
//            let valueVithoutNonPrint = value.filter { !$0.isWhitespace }
//            return (valueVithoutNonPrint.count >= Constants.policyNumberLenghtFrom &&
//                    valueVithoutNonPrint.count <= Constants.policyNumberLenghtTo) ? .success : .failure(ValidationError.policyNumberError)
//       }
//    }
//
//    static var registrationID: Validator {
//        return Validator { value in
//            let isStartsCHE = value.starts(with: Constants.registrationIDStarts)
//            let isDigitsAfterCHE = Array(value).filter { Constants.numbers.contains($0) }.count == Constants.numbersCount
//            let isCorrectCount = value.count == Constants.totalCount
//            return (isStartsCHE && isDigitsAfterCHE && isCorrectCount) ? .success : .failure(ValidationError.registrationIDError)
//       }
//    }
//
//    static var registrationIDWithSymbols: Validator {
//        return Validator { value in
//            guard value.count == Constants.totalCountWithSymbols
//                else { return .failure(ValidationError.registrationIDError) }
//
//            var characters = Array(value)
//
//            guard String(characters.remove(at: 3)) == "-" else {
//                return .failure(ValidationError.registrationIDError)
//            }
//
//            guard String(characters.remove(at: 6)) == "." else {
//                return .failure(ValidationError.registrationIDError)
//            }
//
//            guard String(characters.remove(at: 9)) == "." else {
//                return .failure(ValidationError.registrationIDError)
//            }
//
//            let uid = String(characters)
//            let isStartsCHE = uid.starts(with: Constants.registrationIDStarts)
//            let isDigitsAfterCHE = Array(uid).filter { Constants.numbers.contains($0) }.count == Constants.numbersCount
//            let isCorrectCount = uid.count == Constants.totalCount
//            return (isStartsCHE && isDigitsAfterCHE && isCorrectCount) ? .success : .failure(ValidationError.registrationIDError)
//       }
//    }
//
//    static var company: Validator {
//        return Validator { value in
//            var company = value
//            company.removeAll { $0.isWhitespace }
//            return (company.count >= 2 && company.count <= 150) ? .success : .failure(ValidationError.companyError(from: 2, to: 150))
//       }
//    }
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
