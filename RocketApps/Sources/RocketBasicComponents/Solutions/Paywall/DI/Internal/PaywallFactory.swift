import UIKit
import ComposableArchitecture

class PaywallFactory {
    
    let store: StoreOf<SubscriptionDomain>
    
    weak var router: PaywallRouter?
    
    init(router: PaywallRouter) {
        self.router = router
        self.store = Store(initialState: SubscriptionDomain.State(router: router)) {
            SubscriptionDomain()._printChanges()
        }
    }
    
    func buildPaywallModule() -> PaywallViewController {
        let viewController = PaywallViewController(store: store)
        return viewController
    }
}
