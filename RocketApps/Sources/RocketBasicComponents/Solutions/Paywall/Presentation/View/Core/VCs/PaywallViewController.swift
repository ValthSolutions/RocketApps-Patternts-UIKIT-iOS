import UIKit
import Combine
import Styling
import ComposableArchitecture
import ApphudSDK

open class PaywallViewController: NiblessViewController {
    
    // MARK: -  Properties
    
    private var closeButton = BaseButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
    private var rootView: PaywallRootView?
    private var cancellables = Set<AnyCancellable>()
    
    let store: StoreOf<SubscriptionDomain>
    let viewStore: ViewStore<Redux.ViewState, Redux.ViewAction>
    public init(store: StoreOf<SubscriptionDomain>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: Redux.ViewState.init, send: SubscriptionDomain.Action.init)
        super.init()
    }
    
    public override func loadView() {
        rootView = PaywallRootView(viewStore: viewStore)
        view = rootView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        subscribeToButtonTaps()
        setupCloseButton()
        viewStore.send(.fetchProductDetails)
        handleRestoreTap()
        handleAlert()
    }
    
    open func setupCloseButton() {
        closeButton.decorate(with: Skeleton.ButtonStyles.close)
        
        closeButton.makeConstraints { make in
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .allEvents)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: closeButton)
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

extension PaywallViewController {
    
    @objc private func closeButtonTapped() {
        viewStore.send(.didPressCloseButton)
    }
        
    private func subscribeToButtonTaps() {
        guard let rootView = rootView else { return }
        
        rootView.tryFreeButtonTapped
            .sink { [weak self] _ in
                self?.viewStore.send(.proceedWithPurchase)
            }
            .store(in: &cancellables)
        
        rootView.viewAllPlansButtonTapped
            .sink { [weak self] _ in
                self?.viewStore.send(.navigateToPlanScreen)
            }
            .store(in: &cancellables)
    }
}

extension PaywallViewController: Alertable {
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
