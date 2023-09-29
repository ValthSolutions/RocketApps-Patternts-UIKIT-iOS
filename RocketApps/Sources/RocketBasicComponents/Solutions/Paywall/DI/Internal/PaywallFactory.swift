import UIKit
import ComposableArchitecture
import Combine

class PaywallFactory {
    
    let store: StoreOf<SubscriptionDomain>
    
    weak var router: PaywallRouter?
    private var cancellables: Set<AnyCancellable> = []

    init(router: PaywallRouter) {
        self.router = router
        self.store = Store(initialState: SubscriptionDomain.State(router: router)) {
            SubscriptionDomain()._printChanges()
        }
    }
    
    func buildPaywallVC() -> PaywallViewController {
        let viewController = PaywallViewController(store: store)
        return viewController
    }
    
    func buildPlansVC() -> PlansViewController {
        let viewController = PlansViewController(store: store)
        return viewController
    }
}
