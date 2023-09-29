import UIKit

public struct TextFieldConfiguration {
    let placeholder: String
    let topLabel: String
    let isSecure: Bool
    let autocapitalizationType: UITextAutocapitalizationType
    let keyboardType: UIKeyboardType
    let contentType: UITextContentType?
    let filter: String?
    let needPhoneFormatter: Bool
    public let validationChain: ValidationChain
    
    public init(
        placeholder: String,
        topLabel: String,
        isSecure: Bool = false,
        autocapitalizationType: UITextAutocapitalizationType = .sentences,
        keyboardType: UIKeyboardType = .default,
        contentType: UITextContentType? = nil,
        filter: String? = nil,
        needPhoneFormatter: Bool = false,
        validationChain: ValidationChain
    ) {
        self.placeholder = placeholder
        self.topLabel = topLabel
        self.isSecure = isSecure
        self.autocapitalizationType = autocapitalizationType
        self.keyboardType = keyboardType
        self.contentType = contentType
        self.filter = filter
        self.needPhoneFormatter = needPhoneFormatter
        self.validationChain = validationChain
    }
}
