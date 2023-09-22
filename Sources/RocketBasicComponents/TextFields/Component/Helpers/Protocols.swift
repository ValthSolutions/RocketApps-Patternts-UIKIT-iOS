//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 22.09.2023.
//

import UIKit

/// Conform to this protocol to provide error messanges
public protocol ValidationErrorConvertible {
    var errorDescription: String { get }
}

public enum ErrorState {
    case error(message: String)
    case noError
}

public protocol ValidationResultAdapter: AnyObject {
    associatedtype ErrorType
    associatedtype Result = ValidationResult<ErrorType>
    func applyValidationResult(_ validationResult: Result)
}

public enum ValidationResult<E> {
    case success
    case failure(E)
    
    public var isValid: Bool {
        switch self {
        case .success:
            return true
        case .failure:
            return false
        }
    }
}

extension String: ValidationErrorConvertible {
    public var errorDescription: String {
        return self
    }
}

public protocol TextFieldConfiguration {
    var placeholder: String { get }
    var topLabel: String { get }
    var capitalization: UITextAutocapitalizationType { get }
    var contentType: UITextContentType? { get }
    var keyboardType: UIKeyboardType { get }
    var filter: String? { get }
    var needEyeSecure: Bool { get }
    var needPhoneFormatter: Bool { get }
}
