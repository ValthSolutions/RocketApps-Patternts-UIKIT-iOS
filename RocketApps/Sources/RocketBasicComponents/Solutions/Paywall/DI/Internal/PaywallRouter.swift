import UIKit

class PaywallRouter: Equatable {
    
    private weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func routeToAllPlans() {
        let factory = PaywallFactory(router: self)
        let plansVC = factory.buildPlansVC()
        navigationController?.pushViewController(plansVC, animated: true)
    }
}

extension PaywallRouter {
    static func == (lhs: PaywallRouter, rhs: PaywallRouter) -> Bool {
        true
    }
}
