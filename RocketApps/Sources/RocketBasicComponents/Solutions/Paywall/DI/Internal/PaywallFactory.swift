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
    
    func buildPaywallModule() -> PaywallViewController {
        self.store
            .scope(state: /TicTacToe.State.newGame, action: TicTacToe.Action.newGame)
            .ifLet { [weak self] newGameStore in
                self?.setViewControllers([NewGameViewController(store: newGameStore)], animated: false)
            }
            .store(in: &self.cancellables)
    }
}
