//
//  File.swift
//
//
//  Created by LEMIN DAHOVICH on 02.05.2023.
//

import UIKit

public protocol TitleIdble {
    var id: String { get }
    var title: String { get }
}

public enum InputFieldType {
    
    // MARK: SignUp
    
    case title(values: [TitleIdble])
    case firstName
    case lastName
    case phoneNumber
    case email
    case password
    
    // MARK: Main-info
    
    case dateOfBirdth
    case maritalStatus(values: [TitleIdble])
    case adress
    case additionalAdress
    case postalCode
    case city
    case citizenship
    case country
    case company
    case registrationID
    case companyTitle
    
    // MARK: ResetPassword / CreatePassword
    
    case resetPassword
    case createPassword
    case confirmPassword(TextFieldView?)

    // MARK: Main-info Documents
    
    case documentType(values: [TitleIdble])
    
    // MARK: Insurance Policy
    
    case categoryInsurance
    case companyInsurance
    case policyNumber
    
    // MARK: Get an offer
    
    case note
    
    var placeholder: String {
        switch self {
        case .email:
            return "dava"
        case .password:
            return "dava"
        case .firstName:
            return "dava"
        case .lastName:
            return "dava"
        case .phoneNumber:
            return "00 000 0000"
        case .title:
            return "dava"

        case .dateOfBirdth:
            return "dava"
        case .maritalStatus:
            return "dava"
        case .adress:
            return "dava"
        case .additionalAdress:
            return "dava"
        case .postalCode:
            return "dava"
        case .city:
            return "dava"
        case .citizenship:
            return "dava"
        case .country:
            return "dava"
        case .company:
            return "dava"
        case .registrationID:
            return "dava"
        case .companyTitle:
            return "dava"

        case .documentType:
            return "dava"
        case .categoryInsurance:
            return "dava"
        case .companyInsurance:
            return "dava"
        case .policyNumber:
            return "dava"
        case .resetPassword:
            return "dava"
        case .createPassword:
            return "dava"
        case .confirmPassword:
            return "dava"
        case .note:
            return "dava"
        }
    }
    
    var topLabel: String {
        switch self {
        case .email:
            return "dava"
        case .password:
            return "dava"
        case .firstName:
            return "dava"
        case .lastName:
            return "dava"
        case .phoneNumber:
            return "dava"
        case .title:
            return "dava"

        case .dateOfBirdth:
            return "dava"
        case .maritalStatus:
            return "dava"
        case .adress:
            return "dava"
        case .additionalAdress:
            return "dava"
        case .postalCode:
            return "dava"
        case .city:
            return "dava"
        case .citizenship:
            return "dava"
        case .country:
            return "dava"
        case .company:
            return "dava"
        case .registrationID:
            return "dava"
        case .companyTitle:
            return "dava"

        case .documentType:
            return "dava"
        case .categoryInsurance:
            return "dava"
        case .companyInsurance:
            return "dava"
        case .policyNumber:
            return "dava"
        case .resetPassword:
            return "dava"
        case .createPassword:
            return "dava"
        case .confirmPassword:
            return "dava"
        case .note:
            return "dava"
        }
    }
    
    var capitalization: UITextAutocapitalizationType {
        switch self {
        case .firstName, .lastName:
            return .words
        case .registrationID:
            return .allCharacters
        case .email:
            return .none
        default:
            return .sentences
        }
    }
    
    var contentType: UITextContentType? {
        switch self {
        case .email:
            return .emailAddress
        case .password:
            return .password
        case .firstName:
            return .givenName
        case .lastName:
            return .familyName
        case .dateOfBirdth:
            return .addressCity
        default:
            return nil
        }
    }
    
    var keyboardType: UIKeyboardType {
        switch self {
        case .email:
            return .emailAddress
        case .phoneNumber:
            return .phonePad
        case .postalCode:
            return .numberPad
        default:
            return .default
        }
    }
    
    var filter: String? {
        switch self {
        case .email:
            return "[a-zA-z0-9@._-]"
        default:
            return nil
        }
    }
    
    var needEyeSecure: Bool {
        switch self {
        case .password:
            return true
        case .createPassword:
            return true
        case .confirmPassword:
            return true
        default:
            return false
        }
    }
    
    var needPhoneFormatter: Bool {
        switch self {
        case .phoneNumber:
            return true
        default:
            return false
        }
    }
 
}

extension InputFieldType {
    public var validationChain: ValidationChain {
        switch self {
        case .email:
            return ValidationChain(validators: [Validator.notEmpty])
        default: return ValidationChain(validators: [Validator.notEmpty])
        }
    }
}
