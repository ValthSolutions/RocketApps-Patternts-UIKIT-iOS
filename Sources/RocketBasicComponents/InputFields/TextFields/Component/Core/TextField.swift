import UIKit
import Combine
import Styling

public protocol TextFieldNextDelegate: AnyObject {
    func textFieldShouldReturn(_ textField: TextField) -> Bool
}

public class TextField: UITextField {
    
    @Published public var isValid: Bool = false {
        didSet {
            updateUI()
        }
    }
    
    public var didFinishedEditingClosure: ((String?) -> Void)?
    
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
        
        let font: UIFont = .systemFont(ofSize: 15)
        
        let placeholderColor = color.withAlphaComponent(0.4)
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: placeholderColor,
            .font: font
        ]
        attributedPlaceholder = NSAttributedString(string: text ?? "", attributes: attributes)
    }
    
    public override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.insetBy(dx: 16.0, dy: 0.0)
        
    }
    
    public override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
    
    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
    
    open func setText(_ text: String?) {
        didEndEditingSubject.send(())
        self.text = text
    }
    
    open func setupAppearance() {
        backgroundColor = .clear
        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 4
    }
    
    open func normalState() {
        textColor = normalTextColor
        layer.borderColor = normalBorderColor
    }
    
    open func editingState() {
        textColor = normalTextColor
        layer.borderColor = editingBorderColor
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
    
}

extension TextField: UITextFieldDelegate {
    open func textFieldDidBeginEditing(_ textField: UITextField) {
        editingState()
    }
    
    open func textFieldDidEndEditing(_ textField: UITextField) {
        normalState()
        didEndEditingSubject.send(())
        didFinishedEditingClosure?(text)
    }
    
    open func textField(_ textField: UITextField,
                        shouldChangeCharactersIn range: NSRange,
                        replacementString string: String) -> Bool {
        guard isValidInput(in: range, replacement: string) else { return false }
        updateEditingState()
        return true
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
