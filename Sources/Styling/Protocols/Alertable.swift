import UIKit

public protocol Alertable {
    func showAlert(title: String, subtitle: String, completion: @escaping () -> Void)
}

extension Alertable where Self: UIViewController {
    public func showAlert(title: String, subtitle: String, completion: @escaping () -> Void) {
        let alertController = UIAlertController(title: title,
                                                message: subtitle,
                                                preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            completion()
        }
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}
