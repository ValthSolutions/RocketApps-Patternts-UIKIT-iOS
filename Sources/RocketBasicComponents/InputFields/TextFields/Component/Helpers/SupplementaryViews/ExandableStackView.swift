import UIKit

open class ExpandableStackView: UIStackView, BaseInputViewDelegate {
   
    public var fieldStackViewHeightConstraint: NSLayoutConstraint?
    
    public init(textFields: [TextFieldView]) {
        super.init(frame: .zero)
        axis = .vertical
        alignment = .fill
        distribution = .equalSpacing
        translatesAutoresizingMaskIntoConstraints = false
        for textField in textFields {
            textField.delegate = self
            addArrangedSubview(textField)
        }
    }

    required public init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func textFieldView(_ textFieldView: BaseInputView, didChangeHeight additionalHeight: CGFloat, animated: Bool) {
        adjustStackViewHeight(additionalHeight: additionalHeight, animated: animated)
    }
    
    private func adjustStackViewHeight(additionalHeight: CGFloat, animated: Bool) {
        fieldStackViewHeightConstraint?.constant += additionalHeight
        
        if animated {
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
                self.superview?.layoutIfNeeded()
            }
        } else {
            self.superview?.layoutIfNeeded()
        }
    }
}
