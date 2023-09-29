import UIKit
import Combine
import Styling
import ComposableArchitecture
import ApphudSDK
import Foundation

open class PlansViewController: NiblessViewController {
    
    // MARK: -  Properties
    
    private var rootView: PlansRootView?
    private var cancellables = Set<AnyCancellable>()
    
    let store: StoreOf<SubscriptionDomain>
    let viewStore: ViewStore<Redux.ViewState, Redux.ViewAction>
    
    public init(store: StoreOf<SubscriptionDomain>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: Redux.ViewState.init, send: SubscriptionDomain.Action.init)
        super.init()
    }
    
    public override func loadView() {
        rootView = PlansRootView(viewStore: viewStore)
        view = rootView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        subscribeToButtonTaps()
        handleRestoreTap()
        handleAlert()
    }
    
    open func handlePrivacyTap(completion: @escaping () -> Void) {
        rootView?.footerView.onPrivacyTapped = {
            completion()
        }
    }
    
    open func handleTermsTap(completion: @escaping () -> Void) {
        rootView?.footerView.onTermsTapped = {
            completion()
        }
    }
    
    private func handleRestoreTap() {
        rootView?.footerView.onRestorePurchaseTapped = { [weak self] in
            self?.viewStore.send(.restorePurchases)
        }
    }
}

extension PlansViewController {
    private func subscribeToButtonTaps() {
        guard let rootView = rootView else { return }
        
        rootView.chooseButtonTapped
            .sink { [weak self] _ in
                self?.viewStore.send(.proceedWithPurchase)
            }
            .store(in: &cancellables)
    }
}

extension PlansViewController: Alertable {
    private func handleAlert() {
        viewStore
            .publisher
            .showRestoreFailedAlert
            .subscribe(on: DispatchQueue.main)
            .sink { [weak self] showRestoreFailedAlert in
                guard let strongSelf = self else { return }
                if let shouldShow = showRestoreFailedAlert, shouldShow {
                    strongSelf.showAlert(title: "Error",
                                         subtitle: "No subscriptions to restore") { [weak self] in
                        self?.viewStore.send(.tearDown)
                    }
                }
            }.store(in: &cancellables)
    }
}
