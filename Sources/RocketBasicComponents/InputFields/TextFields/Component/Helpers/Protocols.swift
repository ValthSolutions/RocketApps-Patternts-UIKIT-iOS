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
    case error(message: String, delta: CGFloat)
    case noError(delta: CGFloat)
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
}

// MARK: - BaseInputView

public protocol BaseInputViewDelegate: AnyObject {
    func textFieldView(_ textFieldView: BaseInputView, didChangeHeight additionalHeight: CGFloat, animated: Bool)
}

public protocol TextFieldViewButtonDelegate: AnyObject {
    func textFieldViewDidTapButton(_ textFieldView: TextFieldView)
}

public protocol TextFieldViewDidSelectDelegate: AnyObject {
    func textFieldView(_ textFieldView: TextFieldView, didSelectTitle title: TitleIdble)
}
