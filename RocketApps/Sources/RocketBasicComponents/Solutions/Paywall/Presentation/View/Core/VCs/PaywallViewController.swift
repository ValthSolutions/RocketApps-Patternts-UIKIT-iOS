import UIKit
import Combine
import Styling

open class PaywallViewController: NiblessViewController, IPaywallViewController {
    
    private var rootView: PaywallRootView?
    private var cancellables = Set<AnyCancellable>()
    public let output: IPaywallViewModel
    
    init(output: IPaywallViewModel) {
        self.output = output
        super.init()
    }
    
    public override func loadView() {
        rootView = PaywallRootView()
        view = rootView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        subscribeToButtonTaps()
    }
}

extension PaywallViewController {
    
    private func subscribeToButtonTaps() {
        guard let rootView = rootView else { return }
        
        rootView.tryFreeButtonTapped
            .sink { _ in
                
            }
            .store(in: &cancellables)
        
        rootView.viewAllPlansButtonTapped
            .sink { [weak self] _ in
                self?.output.viewAllPlansButtonTapped()
            }
            .store(in: &cancellables)
    }
}
