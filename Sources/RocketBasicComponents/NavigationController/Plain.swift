import UIKit
import Styling

open class Plain: NavigationControllerDecorator {
    
    private let backButtonImage: UIImage?
    private let fontProfile: FontProfile?
    
    public init(backButtonImage: UIImage? = nil,
                fontProfile: FontProfile? = nil) {
        self.backButtonImage = backButtonImage
        self.fontProfile = fontProfile
    }
    
    open func decorate(_ navigationBar: UINavigationBar) {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.tintColor = .black
        if let fontProfile = fontProfile {
            navigationBar.titleTextAttributes = [NSAttributedString.Key.font: Typography.font(for: fontProfile)]
        }
    }
    
    open func decorateBackButton(for viewController: UIViewController,
                                 selector: Selector) {
        let backButton = UIBarButtonItem(title: "", style: .plain, target: viewController, action: selector)
        viewController.navigationItem.backBarButtonItem = backButton
        
        let actualBackButtonImage = backButtonImage ?? UIImage(named: "button.back")
        
        if let tintedBackButtonImage = actualBackButtonImage?.withRenderingMode(.alwaysTemplate) {
            viewController.navigationController?.navigationBar.backIndicatorImage = tintedBackButtonImage
            viewController.navigationController?.navigationBar.backIndicatorTransitionMaskImage = tintedBackButtonImage
        }
    }
}
