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
