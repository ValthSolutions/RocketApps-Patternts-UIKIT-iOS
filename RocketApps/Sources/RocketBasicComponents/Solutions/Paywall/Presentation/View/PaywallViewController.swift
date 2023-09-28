import UIKit
import Combine
import Styling

open class PaywallViewController: NiblessViewController {
    
    private var rootView: PaywallRootView?

    private var cancellables = Set<AnyCancellable>()
    
    public override func loadView() {
        rootView = PaywallRootView()
        view = rootView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        subscribeToButtonTaps()
//        handleViewState()
    }
}

extension PaywallViewController {
    
    private func subscribeToButtonTaps() {
        guard let rootView = rootView else { return }
        
        rootView.viewAllPlansButtonTapped
            .sink { _ in

            }
            .store(in: &cancellables)
    }
}
//
//// MARK: - Handle ViewState
//
//extension PaywallViewController: Alertable {
//    private func handleViewState() {
//        output.viewState
//            .receive(on: DispatchQueue.main)
//            .sink { [weak self] state in
//                guard let self else { return }
//                switch state {
//                case .initial:
//                    break
//                case .loading:
//                    self.rootView?.signUpButton.startAnimation()
//
//                case .loaded:
//                    self.rootView?.signUpButton.stopAnimation(revertAfterDelay: 0.5, completion: nil)
//
//                case .error(let error):
//                    self.showAlert(error.localizedDescription)
//                    self.rootView?.signUpButton.stopAnimation(revertAfterDelay: 0.5, completion: nil)
//                }
//            }.store(in: &cancellable)
//    }
//}
