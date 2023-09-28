import UIKit
import Combine

public protocol IPaywallViewController: UIViewController {
    var output: IPaywallViewModel { get }
}

public protocol IPaywallViewModel {
    var moduleOutput: PaywallOutput? { get set }
    var viewState: CurrentValueSubject<PaywallViewState, Never> { get set }
    func viewAllPlansButtonTapped()
}

// MARK: - Output

public protocol PaywallOutput: AnyObject {
    
}

// MARK: - ViewState

public enum PaywallViewState: Equatable {
    case initial
    case loading
    case loaded
    case error(Error)
    
    static public func == (lhs: PaywallViewState, rhs: PaywallViewState) -> Bool {
      switch (lhs, rhs) {
      case (.loading, .loading):
        return true
      case ( .initial, .initial):
        return true
      case (.error, .error):
        return true
      case (.loaded, .loaded):
        return true
      default:
        return false
      }
    }
}
