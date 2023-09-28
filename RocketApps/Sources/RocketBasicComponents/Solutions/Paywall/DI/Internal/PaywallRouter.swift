import UIKit

class PaywallRouter: Equatable {
    
    private weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func routeToAllPlans() {
        let plansVC = UIViewController()
        navigationController?.pushViewController(plansVC, animated: true)
    }
}

extension PaywallRouter {
    static func == (lhs: PaywallRouter, rhs: PaywallRouter) -> Bool {
        true
    }
}
