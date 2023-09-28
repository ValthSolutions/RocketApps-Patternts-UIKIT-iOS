import ComposableArchitecture
import Foundation
import ApphudSDK

public struct SubscriptionDomain: ReducerProtocol {
    enum SubscriptionContext {
        case onboarding
        case regularSubscription
    }
    
    public struct State: Equatable {
        var hasUsedTrial = true
        var selectedProduct: ApphudProduct?
        var productDetails: [ApphudProduct] = []
        var dataLoadingStatus = DataLoadingStatus.notStarted
        var isPurchaseInProgress: Bool = false
        var showRestoreFailedAlert = false
        var subscriptionContext: SubscriptionContext = .regularSubscription
        var router: PaywallRouter
        
        var shouldShowError: Bool {
            dataLoadingStatus == .error
        }
        
        var isLoading: Bool {
            dataLoadingStatus == .loading
        }
        
        init(subscriptionContext: SubscriptionContext = .regularSubscription,
             router: PaywallRouter
        ) {
            self.router = router
            self.subscriptionContext = subscriptionContext
        }
    }
    
    private enum CancelID: CaseIterable {
        case productDetails
    }
    
    public enum Action: Equatable {
        case selectProduct(ApphudProduct)
        case proceedWithPurchase
        case purchaseProductSuccess
        case purchaseProductFailure
        case restoreProductFailure
        case didPressCloseButton
        case restorePurchases
        case viewAllPlansButtonTapped
        case navigateToWelcomeScreen
        case links
        case teardown
        case fetchProductDetails
        case fetchProductDetailsResponse(TaskResult<[ApphudProduct]>)
    }
    
    @Dependency(\.appHudService) private var appHudService

    public var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .navigateToWelcomeScreen:
                return .none
            case .viewAllPlansButtonTapped:
                return .none
            case .restoreProductFailure:
                state.showRestoreFailedAlert = true
                state.isPurchaseInProgress = false
                return .none
            case .teardown:
                return .merge(.cancel(id: CancelID.allCases))
            case .didPressCloseButton:
                state.showRestoreFailedAlert = false
                return .none
            case .proceedWithPurchase:
                state.isPurchaseInProgress = true
                let plan = state.selectedProduct
                return .run { send in
                    if let product = plan {
                        do {
                            try await appHudService.purchase(product: product)
                            await send(.purchaseProductSuccess)
                        } catch {
                            await send(.purchaseProductFailure)
                        }
                    } else {
                        await send(.purchaseProductFailure)
                    }
                }
            case .restorePurchases:
                let currentContext = state.subscriptionContext
                state.isPurchaseInProgress = true
                return .run { send in
                    do {
                        try await appHudService.restorePurchases()
                        switch currentContext {
                        case .onboarding:
                            await send(.navigateToWelcomeScreen)
                        case .regularSubscription:
                            await send(.purchaseProductSuccess)
                        }
                    } catch {
                        await send(.restoreProductFailure)
                    }
                }
                
            case .selectProduct(let plan):
                state.selectedProduct = plan
                return .none
            case .links:
                return .none
            case .fetchProductDetails:
                if state.dataLoadingStatus == .success || state.dataLoadingStatus == .loading {
                    return .none
                }
                state.dataLoadingStatus = .loading
                state.hasUsedTrial = appHudService.hasUsedIntroductoryOffer()
                return .run { send in
                    await send(.fetchProductDetailsResponse(
                        TaskResult { try await appHudService.productDetails() }
                    ))
                }
                .cancellable(id: CancelID.productDetails)
            case .purchaseProductSuccess:
                state.isPurchaseInProgress = false
                return .send(.didPressCloseButton)
            case .purchaseProductFailure:
                state.isPurchaseInProgress = false
                return .none
                
            case .fetchProductDetailsResponse(.success(let details)):
                state.dataLoadingStatus = .success
                state.productDetails = details
                if state.selectedProduct == nil, let firstProduct = details.first {
                    state.selectedProduct = firstProduct
                }
                return .none
                
            case .fetchProductDetailsResponse(.failure):
                state.dataLoadingStatus = .error
                return .none
            }
        }
    }
}
