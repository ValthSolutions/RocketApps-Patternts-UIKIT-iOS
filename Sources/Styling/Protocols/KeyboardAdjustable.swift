import UIKit

public protocol KeyboardAdjustable: AnyObject {
    var scrollView: UIScrollView { get }
    var initialBottomInset: CGFloat { get }
    var keyboardDistanceFromText: CGFloat { get }
    func registerForKeyboardNotifications()
    func unregisterForKeyboardNotifications()
    func keyboardWillShow(notification: Notification)
    func keyboardWillHide(notification: Notification)
}

public extension KeyboardAdjustable where Self: UIView {
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { [weak self] notification in
            self?.keyboardWillShow(notification: notification)
        }
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { [weak self] notification in
            self?.keyboardWillHide(notification: notification)
        }
    }
    
    func unregisterForKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillShow(notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
              let activeField = UIResponder.current as? UIView else {
            return
        }

        let keyboardHeight = keyboardSize.height
        scrollView.contentInset.bottom = initialBottomInset + keyboardHeight
        scrollView.verticalScrollIndicatorInsets.bottom = keyboardHeight

        let convertedFrame = activeField.convert(activeField.bounds, to: scrollView)
        let targetY = convertedFrame.origin.y + convertedFrame.height + keyboardDistanceFromText
        let requiredOffsetY = targetY - scrollView.bounds.height + keyboardHeight
        let fieldBottomY = convertedFrame.origin.y + convertedFrame.height
        let visibleAreaHeight = scrollView.bounds.height - keyboardHeight
        
        if requiredOffsetY > scrollView.contentOffset.y {
            scrollView.setContentOffset(CGPoint(x: scrollView.contentOffset.x, y: requiredOffsetY), animated: true)
        } else if fieldBottomY > (scrollView.contentOffset.y + visibleAreaHeight) || convertedFrame.origin.y < scrollView.contentOffset.y {
            scrollView.setContentOffset(CGPoint(x: scrollView.contentOffset.x, y: requiredOffsetY), animated: true)
        }
    }
    
    func keyboardWillHide(notification: Notification) {
        scrollView.contentInset.bottom = initialBottomInset
        scrollView.verticalScrollIndicatorInsets.bottom = initialBottomInset
    }
}

public extension UIResponder {
    private static weak var _currentFirstResponder: UIResponder?

    static var current: UIResponder? {
        _currentFirstResponder = nil
        UIApplication.shared.sendAction(#selector(UIResponder.findFirstResponder(_:)), to: nil, from: nil, for: nil)
        return _currentFirstResponder
    }

    @objc private func findFirstResponder(_ sender: Any) {
        UIResponder._currentFirstResponder = self
    }
}
