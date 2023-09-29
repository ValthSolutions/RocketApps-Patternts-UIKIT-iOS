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
