import UIKit
import Combine

extension UITextField {
    var textDidChangePublisher: AnyPublisher<String?, Never> {
        let textDidChangePublisher = NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: self)
            .map { notification in
                (notification.object as? UITextField)?.text
            }
        
        let textDidEndEditingPublisher = NotificationCenter.default
            .publisher(for: UITextField.textDidEndEditingNotification, object: self)
            .map { notification in
                (notification.object as? UITextField)?.text
            }
        
        return Publishers.Merge(textDidChangePublisher, textDidEndEditingPublisher)
            .removeDuplicates()
            .eraseToAnyPublisher()
    }
}
