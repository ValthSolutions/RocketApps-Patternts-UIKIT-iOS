import Foundation
import StoreKit

protocol PricedProduct {
    var price: NSDecimalNumber { get }
    var priceLocale: Locale { get }
}

extension SKProduct: PricedProduct {}

extension PricedProduct {
    func getLocalizedPrice() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = self.priceLocale
        formatter.positiveFormat = "¤#,##0.00"
        formatter.negativeFormat = "-¤#,##0.00"
        if let formatted = formatter.string(from: self.price) {
            return formatted
        } else {
            return "\(self.price)"
        }
    }
}
