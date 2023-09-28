import UIKit

class PaywallFactory {
    
    weak var router: PaywallRouter?
    
    init(router: PaywallRouter) {
        self.router = router
    }
    
    func buildPaywallModule() -> PaywallViewController {
        let viewModel = PaywallViewModel(router: router)
        let viewController = PaywallViewController(output: viewModel)
        return viewController
    }
}
