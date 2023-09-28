import ComposableArchitecture
import ApphudSDK
import StoreKit

enum AppHudError: Error {
    case noPaywall
    case noProducts
    case purchaseFailed
}

enum AppHudServiceKey: DependencyKey {
    static let liveValue = AppHudService.live
}

extension DependencyValues {
    var appHudService: IAppHudService {
        get { self[AppHudServiceKey.self] }
        set { self[AppHudServiceKey.self] = newValue }
    }
}

protocol IAppHudService {
    func hasUsedIntroductoryOffer() -> Bool
    var productDetails: @Sendable () async throws -> [ApphudProduct] { get }
    func restorePurchases() async throws
    func purchase(product: ApphudProduct) async throws
    func isUserPremium() -> Bool
}

extension AppHudService {
    static let live: IAppHudService = AppHudService()
}

struct AppHudService: IAppHudService {
    
    func hasUsedIntroductoryOffer() -> Bool {
        guard let subscription = Apphud.subscription() else {
            return false
        }
        return subscription.isIntroductoryActivated
    }
    
    var productDetails: @Sendable () async throws -> [ApphudProduct] {
        return {
            return try await withCheckedThrowingContinuation { continuation in
                Apphud.paywallsDidLoadCallback { paywalls in
                    if let paywall = paywalls.first(where: { $0.identifier == Constants.paywallID}) {
                        let products = paywall.products

                        if products.isEmpty {
                            continuation.resume(throwing: AppHudError.noProducts)
                        } else {
                            continuation.resume(returning: products)
                        }
                    } else {
                        continuation.resume(throwing: AppHudError.noPaywall)
                    }
                }
            }
        }
    }
    
    func restorePurchases() async throws {
        return try await withCheckedThrowingContinuation { continuation in
            Apphud.restorePurchases { restoredSubscriptions, nonRenewingPurchases, error in
                if let err = error {
                    continuation.resume(throwing: err)
                    return
                }

                let hasActiveSubscription = restoredSubscriptions?.contains(where: { $0.isActive() }) ?? false
                
                if hasActiveSubscription {
                    continuation.resume(returning: ())
                } else {
                    let noActiveSubscriptionError = NSError(
                        domain: "ApphudService",
                        code: 999,
                        userInfo: [NSLocalizedDescriptionKey: "subscription.alert.error.description"]
                    )
                    continuation.resume(throwing: noActiveSubscriptionError)
                }
            }
        }
    }
    
    func purchase(product: ApphudProduct) async throws {
        return try await withCheckedThrowingContinuation { continuation in
            Apphud.purchase(product) { result in
                if result.success {
                    continuation.resume(returning: ())
                } else if let error = result.error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume(throwing: AppHudError.purchaseFailed)
                }
            }
        }
    }
    
    func isUserPremium() -> Bool {
        Apphud.hasPremiumAccess()
    }
}

private extension AppHudService {
    enum Constants {
        static let paywallID = "premium_content"
    }
}
