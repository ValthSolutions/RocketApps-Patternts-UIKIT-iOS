import UIKit
import Combine

public protocol TextFieldNextDelegate: AnyObject {
    func textFieldShouldReturn(_ textField: TextField) -> Bool
}

public class TextField: UITextField {
    
    @Published public var isValid: Bool = false {
        didSet {
            updateUI()
        }
    }
    
    
    public var isPhone: Bool = false
    public let didEndEditingSubject = PassthroughSubject<Void, Never>()
    public weak var nextDelegate: TextFieldNextDelegate?
    
    let editingBorderColor = UIColor.blue.cgColor
    let normalBorderColor = UIColor.gray.cgColor
    
    var errorColor: UIColor = .red
    var normalTextColor: UIColor = .black
    private var isEditingStarted: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        spellCheckingType = .no
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    public func setPlaceholder(_ text: String?, color: UIColor = UIColor.black) {
        
        let font: UIFont = .italicSystemFont(ofSize: 12)
        
        let placeholderColor = color.withAlphaComponent(0.4)
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: placeholderColor,
            .font: font
        ]
        attributedPlaceholder = NSAttributedString(string: text ?? "", attributes: attributes)
    }
    
    public override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        if isPhone {
            return rect.insetBy(dx: 8.0, dy: 0.0)
        } else {
            return rect.insetBy(dx: 16.0, dy: 0.0)
        }
    }
    
    public override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
    
    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
    
    public func setText(_ text: String?) {
        didEndEditingSubject.send(())
        self.text = text
        NotificationCenter.default.post(name: UITextField.textDidEndEditingNotification, object: self)
    }
    
    private func setup() {
        normalState()
        delegate = self
        setupAppearance()
    }
    
    func setupAppearance() {
        backgroundColor = .clear
        layer.borderColor = UIColor.blue.cgColor
            layer.borderWidth = 1.0
            layer.cornerRadius = 4
    }
    
    private func updateUI() {
        if isValid && isEditing {
            normalState()
            editingState()
        } else if isValid {
            normalState()
        }
    }
    
    func normalState() {
        textColor = normalTextColor
        layer.borderColor = normalBorderColor
    }
    
    func editingState() {
        textColor = normalTextColor
        layer.borderColor = editingBorderColor
    }
}

extension TextField: UITextFieldDelegate {
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        editingState()
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        normalState()
        didEndEditingSubject.send(())
    }
    
    public func textField(_ textField: UITextField,
                          shouldChangeCharactersIn range: NSRange,
                          replacementString string: String) -> Bool {
        guard isValidInput(in: range, replacement: string) else { return false }
        updateEditingState()
        return !isPhone
    }
    
    private func isValidInput(in range: NSRange, replacement string: String) -> Bool {
        if range.location == 0 && string == " " {
            return false
        }
        
        let oldText = self.text ?? ""
        let newText = (oldText as NSString).replacingCharacters(in: range, with: string)
        if newText.contains("  ") {
            return false
        }

        return true
    }

    private func updateEditingState() {
        editingState()
        didEndEditingSubject.send()
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return nextDelegate?.textFieldShouldReturn(self) ?? true
    }
}

class TextFieldDelegate {
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> (shouldChange: Bool, text: String) {
        let newString = NSString(string: textField.text ?? "").replacingCharacters(in: range, with: string)
        let formattedString = formatPhoneNumber(newString)
        return (false, formattedString)
    }
    
    func formatPhoneNumber(_ phoneNumber: String) -> String {
        let rawNumber = phoneNumber.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression, range: nil)
        var formattedString = ""
        var index = 0
        for char in rawNumber {
            if index == 2 || index == 5 {
                formattedString += " "
            }
            formattedString += String(char)
            index += 1
        }
        return formattedString
    }
}
