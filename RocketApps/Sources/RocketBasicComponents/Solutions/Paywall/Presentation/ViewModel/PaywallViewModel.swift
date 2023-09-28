import Combine

open class PaywallViewModel: IPaywallViewModel {
    public var moduleOutput: PaywallOutput?
    public var viewState = CurrentValueSubject<PaywallViewState, Never>(.initial)

    private let router: PaywallRouter?
    
    init(router: PaywallRouter?) {
        self.router = router
    }
    
    public func viewAllPlansButtonTapped() {
        router?.routeToAllPlans()
    }
}
