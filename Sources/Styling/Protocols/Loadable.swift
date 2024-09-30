import UIKit

public protocol Loadable: AnyObject {
    func showLoader(color: UIColor,
                    style: UIActivityIndicatorView.Style)
    func hideLoader()
}

private var loaderViewKey: UInt8 = 0

public extension Loadable where Self: UIViewController {
    
    private var loaderView: UIActivityIndicatorView? {
        get {
            return objc_getAssociatedObject(self, &loaderViewKey) as? UIActivityIndicatorView
        }
        set {
            objc_setAssociatedObject(self, &loaderViewKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func showLoader(color: UIColor = .black,
                    style: UIActivityIndicatorView.Style = .large
    ) {
        guard loaderView == nil else { return }
        
        let loader = UIActivityIndicatorView(style: style)
        loader.color = color
        loader.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loader)
        
        NSLayoutConstraint.activate([
            loader.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        loader.startAnimating()
        self.loaderView = loader
    }
    
    func hideLoader() {
        loaderView?.stopAnimating()
        loaderView?.removeFromSuperview()
        loaderView = nil
    }
}

public extension Loadable where Self: UICollectionViewCell {
    
    private var loaderView: UIActivityIndicatorView? {
        get {
            return objc_getAssociatedObject(self, &loaderViewKey) as? UIActivityIndicatorView
        }
        set {
            objc_setAssociatedObject(self, &loaderViewKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func showLoader(color: UIColor = .black,
                    style: UIActivityIndicatorView.Style = .medium
    ) {
        guard loaderView == nil else { return }
        
        let loader = UIActivityIndicatorView(style: style)
        loader.color = color
        loader.translatesAutoresizingMaskIntoConstraints = false
        addSubview(loader)
        
        NSLayoutConstraint.activate([
            loader.centerXAnchor.constraint(equalTo: centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        loader.startAnimating()
        self.loaderView = loader
    }
    
    func hideLoader() {
        loaderView?.stopAnimating()
        loaderView?.removeFromSuperview()
        loaderView = nil
    }
}
