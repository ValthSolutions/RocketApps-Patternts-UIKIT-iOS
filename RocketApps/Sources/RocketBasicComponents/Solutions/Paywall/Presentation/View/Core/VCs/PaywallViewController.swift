import UIKit
import Combine
import Styling
import ComposableArchitecture
import ApphudSDK

open class PaywallViewController: NiblessViewController, IPaywallViewController {
    
    // MARK: -  Properties
    
    private var closeButton = BaseButton()
    private var rootView: PaywallRootView?
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
        case navigateToWelcomeScreen
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
        rootView = PaywallRootView()
        view = rootView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        subscribeToButtonTaps()
        setupCloseButton()
    }
}

extension PaywallViewController {
    private func setupCloseButton() {
        closeButton.decorate(with: Skeleton.ButtonStyles.close)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: closeButton)
    }
    
    private func subscribeToButtonTaps() {
        guard let rootView = rootView else { return }
        
        rootView.tryFreeButtonTapped
            .sink { _ in
                
            }
            .store(in: &cancellables)
        
        rootView.viewAllPlansButtonTapped
            .sink { _ in

            }
            .store(in: &cancellables)
    }
}

extension SubscriptionDomain.Action {
  init(action: PaywallViewController.ViewAction) {
    switch action {
    case let .selectProduct(product):
      self = .selectProduct(product)
    case .proceedWithPurchase:
      self = .proceedWithPurchase
    case .restorePurchases:
      self = .restorePurchases
    case .navigateToWelcomeScreen:
      self = .navigateToWelcomeScreen
    case .viewAllPlansButtonTapped:
        self = .viewAllPlansButtonTapped
    case .fetchProductDetails:
        self = .fetchProductDetails
    }
  }
}
