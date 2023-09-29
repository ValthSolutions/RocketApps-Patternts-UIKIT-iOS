import UIKit

open class NavigationController: UINavigationController {
    
    fileprivate var decorator: NavigationControllerDecorator
    
    open override var childForStatusBarStyle: UIViewController? {
        return visibleViewController
    }
    
    public init(nibName nibNameOrNil: String?,
                bundle nibBundleOrNil: Bundle?,
                decorator: NavigationControllerDecorator) {
        
        self.decorator = decorator
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        decorate()
    }
    
    public init?(coder aDecoder: NSCoder, decorator: NavigationControllerDecorator) {
        self.decorator = decorator
        super.init(coder: aDecoder)
        decorate()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("not implemented")
    }
    
    override open func pushViewController(_ viewController: UIViewController, animated: Bool) {
        view.endEditing(true)
        
        decorator.decorateBackButton(for: viewController, selector: #selector(self.pop(sender:)))
        
        super.pushViewController(viewController, animated: animated)
    }
    
    override open func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        view.endEditing(true)
        
        if let vc = viewControllers.last {
            decorator.decorateBackButton(for: vc, selector: #selector(self.pop(sender:)))
        }
        
        super.setViewControllers(viewControllers, animated: animated)
    }
    
    @objc open func pop(sender: UIBarButtonItem) {
        view.endEditing(true)
        
        if viewControllers.count > 1 {
            super.popViewController(animated: true)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }

    fileprivate func decorate() {
        decorator.decorate(self.navigationBar)
    }
}
