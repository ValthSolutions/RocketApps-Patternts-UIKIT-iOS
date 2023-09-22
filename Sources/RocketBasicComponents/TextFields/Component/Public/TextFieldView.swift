import UIKit

open class TextFieldView: BaseInputView {
    
    // MARK: - Constants
    enum Constants {
      
    }
    
    // MARK: - Properties and UI elements
    public override var isValid: Bool {
        didSet {
            inputTextField.isValid = isValid
        }
    }
    
    public override var nextInput: UIResponder? {
        didSet {
            inputTextField.returnKeyType = nextInput == nil ? .done : .next
        }
    }
    
    public lazy var inputTextField: TextField = {
        let textField = TextField()
        return textField
    }()
}
