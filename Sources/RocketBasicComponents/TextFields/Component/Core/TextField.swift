import UIKit
import Combine

public protocol TextFieldNextDelegate: AnyObject {
    func textFieldShouldReturn(_ textField: TextField) -> Bool
}

open class TextField: UITextField {
    
    public var didFinishedEditingClosure: ((String?) -> Void)?
    public var isPhone: Bool = false
    public weak var nextDelegate: TextFieldNextDelegate?
    
    @Published public var isValid: Bool = false {
        didSet {
            updateUI()
        }
    }
    
    let editingBorderColor = UIColor.red.cgColor
    let normalBorderColor = UIColor.blue.cgColor
    
    var errorColor: UIColor = .red
    var normalTextColor: UIColor = .black
    private var isEditingStarted: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        spellCheckingType = .no
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    open func setPlaceholder(_ text: String?, color: UIColor = UIColor.black) {
        
        let font: UIFont = .boldSystemFont(ofSize: 12)
        
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
        self.text = text
    }
    
    private func updateUI() {
        if isValid && isEditing {
            normalState()
            editingState()
        } else if isValid {
            normalState()
        }
    }
    
    private func setup() {
        normalState()
        delegate = self
        setupAppearance()
    }
    
    open func setupAppearance() {
        backgroundColor = .clear
        if isPhone {
            layer.borderWidth = 0
        } else {
            layer.borderColor = .init(red: 0.1, green: 0.9, blue: 1, alpha: 0.5)
            layer.borderWidth = 1.0
            layer.cornerRadius = 4
        }
    }
    
    open func normalState() {
        textColor = normalTextColor
        layer.borderColor = normalBorderColor
    }
    
    open func editingState() {
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
    }
    
    public func textField(_ textField: UITextField,
                          shouldChangeCharactersIn range: NSRange,
                          replacementString string: String) -> Bool {
        updateEditingState()
        return !isPhone
    }

    private func updateEditingState() {
        editingState()
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return nextDelegate?.textFieldShouldReturn(self) ?? true
    }
}
