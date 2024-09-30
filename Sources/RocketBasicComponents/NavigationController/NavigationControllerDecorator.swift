import UIKit

public protocol NavigationControllerDecorator {
    func decorate(_ navigationBar: UINavigationBar)
    func decorateBackButton(for viewController: UIViewController,
                            selector: Selector)
}
