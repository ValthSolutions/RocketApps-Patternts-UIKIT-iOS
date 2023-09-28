import UIKit

class PaywallRouter {
    private weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func routeToAllPlans() {
        let plansVC = UIViewController()
        navigationController?.pushViewController(plansVC, animated: true)
    }
}
