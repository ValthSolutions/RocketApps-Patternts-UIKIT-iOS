import UIKit
import Styling
/// The protocol which defines a delegate to receive a callback once onboarding is completed.
protocol CarouselViewControllerDelegate: AnyObject {
    
    /// Called when the onboarding process finishes in the CarouselViewController.
    ///
    /// - Parameter onboarding: The `CarouselViewController` where the onboarding was completed.
    func onboardingDidFinish(_ onboarding: CarouselViewController)
}

/// A view controller that displays a series of images in a carousel format, useful for onboarding experiences.
open class CarouselViewController: NiblessViewController {
    
    /// The delegate that will receive events from this CarouselViewController.
    weak var delegate: CarouselViewControllerDelegate?
    var pageViewController: UIPageViewController
    var images: [UIImage] = []
    var viewControllersList: [UIViewController] = []
    
    /// Initializes a new `CarouselViewController` with a set of images.
    ///
    /// - Parameter images: The images to be displayed in the carousel.
    public init(images: [UIImage]) {
        self.pageViewController = UIPageViewController(transitionStyle: .scroll,
                                                       navigationOrientation: .horizontal, options: nil)
        self.images = images
        viewControllersList = images.map { image -> UIViewController in
            let contentVC = ContentViewController()
            contentVC.contentImage = image
            return contentVC
        }
        super.init()
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        pageViewController.setViewControllers([viewControllersList[0]], direction: .forward, animated: true, completion: nil)
        pageViewController.dataSource = self
        
        self.addChild(pageViewController)
        self.view.addSubview(pageViewController.view)
        
    }
    
    /// Navigates to the next image in the carousel. If there is no next image, the delegate method `onboardingDidFinish` is called.
    open func navigateToNextViewController() {
        guard let currentVC = pageViewController.viewControllers?.first,
              let index = viewControllersList.firstIndex(of: currentVC),
              index < (viewControllersList.count - 1) else {
            delegate?.onboardingDidFinish(self)
            return
        }
        let nextVC = viewControllersList[index + 1]
        pageViewController.setViewControllers([nextVC], direction: .forward, animated: true, completion: nil)
    }
    
    @objc func handleSwipeGesture(_ gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .up {
            navigateToNextViewController()
        }
    }
}

extension CarouselViewController: UIPageViewControllerDataSource {
    open func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = viewControllersList.firstIndex(of: viewController), index > 0 else { return nil }
        return viewControllersList[index - 1]
    }
    
    open func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = viewControllersList.firstIndex(of: viewController), index < (viewControllersList.count - 1) else { return nil }
        return viewControllersList[index + 1]
    }
}
