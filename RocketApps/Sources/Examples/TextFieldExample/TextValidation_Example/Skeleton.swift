
import UIKit

class Skeleton {
    // MARK: - TextField Configuration
    struct TextFieldConfigs {
        static var primary: TextFieldConfiguration {
            return TextFieldConfiguration(
                placeholder: "Email",
                topLabel: "Your Email Address",
                keyboardType: .emailAddress,
                contentType: .emailAddress,
                validationChain: ValidationChain(validators: [Validator.notEmpty],
                                                 validationError: DefaultValidationError.emptyValue)
            )
        }
        
        static var secondary: TextFieldConfiguration {
            return TextFieldConfiguration(
                placeholder: "Custom Placeholder",
                topLabel: "Custom Label",
                keyboardType: .default,
                validationChain: ValidationChain(validators: [Validator.notEmpty],
                                                 validationError: DefaultValidationError.emptyValue)
            )
        }
    }
}
