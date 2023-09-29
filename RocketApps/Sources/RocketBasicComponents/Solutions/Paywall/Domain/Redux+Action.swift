//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 29.09.2023.
//

import Foundation
import ApphudSDK

public struct Redux {
    public struct ViewState: Equatable {
        let isButtonEnabled: Bool
        let isPurchaseInFlight: Bool
        let productDetails: [ApphudProduct]
        let dataLoadingStatus: DataLoadingStatus
        
        public init(state: SubscriptionDomain.State) {
            self.isButtonEnabled = !state.productDetails.isEmpty && !state.productDetails.isEmpty
            self.isPurchaseInFlight = state.isPurchaseInProgress
            self.productDetails = state.productDetails
            self.dataLoadingStatus = state.dataLoadingStatus
        }
    }
    
    public enum ViewAction {
        case viewAllPlansButtonTapped
        case restorePurchases
        case didPressCloseButton
        case navigateToPlanScreen
        case proceedWithPurchase
        case selectProduct(ApphudProduct)
        case fetchProductDetails
    }
}

extension SubscriptionDomain.Action {
  init(action: Redux.ViewAction) {
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
