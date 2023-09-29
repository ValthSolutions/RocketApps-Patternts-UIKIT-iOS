import UIKit
import Combine
import Styling
import ComposableArchitecture
import ApphudSDK

open class PlansViewController: NiblessViewController {
    
    // MARK: -  Properties
    
    private var rootView: PlansRootView?
    private var cancellables = Set<AnyCancellable>()
    
    let store: StoreOf<SubscriptionDomain>
    let viewStore: ViewStore<ViewState, ViewAction>

    struct ViewState: Equatable {
        let isButtonEnabled: Bool

        public init(state: SubscriptionDomain.State) {
            self.isButtonEnabled = !state.productDetails.isEmpty && !state.productDetails.isEmpty
        }
    }
    
    enum ViewAction {
        case viewAllPlansButtonTapped
        case restorePurchases
        case didPressCloseButton
        case navigateToPlanScreen
        case proceedWithPurchase
        case selectProduct(ApphudProduct)
        case fetchProductDetails
    }
    
    public init(store: StoreOf<SubscriptionDomain>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: ViewState.init, send: SubscriptionDomain.Action.init)
        super.init()
    }
    
    public override func loadView() {
        rootView = PlansRootView()
        view = rootView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        subscribeToButtonTaps()
    }
}

extension PlansViewController {
    
    @objc private func closeButtonTapped() {
        viewStore.send(.didPressCloseButton)
    }
    
    private func subscribeToButtonTaps() {
        guard let rootView = rootView else { return }
        
        rootView.chooseButtonTapped
            .sink { [weak self] _ in
                self?.viewStore.send(.proceedWithPurchase)
            }
            .store(in: &cancellables)
    }
}

extension SubscriptionDomain.Action {
  init(action: PlansViewController.ViewAction) {
    switch action {
    case .navigateToPlanScreen:
        self = .navigateToPlanScreen
    case let .selectProduct(product):
      self = .selectProduct(product)
    case .proceedWithPurchase:
      self = .proceedWithPurchase
    case .restorePurchases:
      self = .restorePurchases
    case .viewAllPlansButtonTapped:
        self = .viewAllPlansButtonTapped
    case .fetchProductDetails:
        self = .fetchProductDetails
    case .didPressCloseButton:
        self = .didPressCloseButton
    }
  }
}
