import UIKit
import Styling
import Combine
import ComposableArchitecture

open class PaywallRootView: NiblessView {
    
    // MARK: - Properties
    private var cancellables = Set<AnyCancellable>()
    private let viewStore: ViewStore<Redux.ViewState, Redux.ViewAction>

    private(set) lazy var tryFreeButton = BaseButton()
    private(set) lazy var tryFreeButtonTapped = createButtonTapPublisher(for: tryFreeButton)
    
    private(set) lazy var viewAllPlansButton = BaseButton()
    private(set) lazy var viewAllPlansButtonTapped = createButtonTapPublisher(for: viewAllPlansButton)
    
    private(set) lazy var hStack: UIStackView = {
        $0.spacing = Spacing.step5.rawValue
        $0.alignment = .center
        $0.axis = .horizontal
        return $0
    }(UIStackView())
    
    private let hScrollView: UIScrollView = {
        $0.showsHorizontalScrollIndicator = false
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIScrollView())
    
    private let registrationFooterView = RegistrationFooterView()
    private let autoRenewableLabel = BaseLabel()
    private let navigationView = CustomNavigationView()
    private var subscriptionView = SubscriptionView(product: nil)
    
    // MARK: - Init
    
    public init(viewStore: ViewStore<Redux.ViewState, Redux.ViewAction>
    ) {
        self.viewStore = viewStore
        super.init(frame: .zero)
        setupUI()
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        hScrollView.contentInset = UIEdgeInsets(top: 16, left: 16, bottom: 30, right: 16 + 30)
    }
    
    open func applyDecorations() {
        
    }
}

// MARK: - Private

extension PaywallRootView {
    private func setupSubView() {
        viewStore.publisher.dataLoadingStatus.sink { [weak self] status in
            guard let self else { return }
            if status == .success {
                let product = viewStore.state.productDetails.first
                subscriptionView.product = product
            }
        }.store(in: &cancellables)
    }
    
    private func setupUI() {
        setupSubView()
        backgroundColor = .white
        hScrollView.showsVerticalScrollIndicator = false
        hScrollView.backgroundColor = .clear
        setupHierarchy()
        setupConstraints()
        registrationFooterView.decorate(with: .init())
        
        navigationView.setTitle("Get full access to Floro Premium")
        navigationView.decorate(with: .default)
        
        let buttonStyles = Skeleton.ButtonStyles.tryFreeStyle
        tryFreeButton.setTitle(buttonStyles.0, for: .normal)
        tryFreeButton.decorate(with: buttonStyles.1)
        
        let labelStyles = Skeleton.LabelStyles.autoRenewable
        autoRenewableLabel.text = labelStyles.0
        autoRenewableLabel.decorate(with: labelStyles.1)
        
        let viewAllPlansStyle = Skeleton.ButtonStyles.viewAllPlans
        viewAllPlansButton.setTitle(viewAllPlansStyle.0, for: .normal)
        viewAllPlansButton.decorate(with: viewAllPlansStyle.1)
        
        subscriptionView.decorate(with: .default)
        
        let views = [BenefitView(), BenefitView(), BenefitView(), BenefitView()]
        _ = views.map { benefitView in
            hStack.addArrangedSubview(benefitView)
            benefitView.translatesAutoresizingMaskIntoConstraints = false
            benefitView.decorate(with: .default)
        }
    }
    
    @objc private func dismissKeyboard() {
        endEditing(true)
    }
}

// MARK: - Hierarchy

extension PaywallRootView {
    private func setupHierarchy() {
        addSubview(hScrollView)
        hScrollView.addSubview(hStack)
        addSubview(registrationFooterView)
        addSubview(tryFreeButton)
        addSubview(subscriptionView)
        addSubview(viewAllPlansButton)
        addSubview(autoRenewableLabel)
        addSubview(navigationView)
    }
}

// MARK: - Constraints

extension PaywallRootView {
    private func setupConstraints() {
        let spacer = UIView()
        spacer.isUserInteractionEnabled = false
        addSubview(spacer)
        
        navigationView.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(leadingAnchor)
            make.trailing.equalTo(trailingAnchor)
            make.height.equalTo(heightAnchor, multiplier: 0.33)
        }
        
        hScrollView.makeConstraints { make in
            make.top.equalTo(navigationView.bottomAnchor)
            make.bottom.equalTo(viewAllPlansButton.topAnchor)
            make.leading.equalTo(leadingAnchor)
            make.trailing.equalTo(trailingAnchor)
        }
        
        hStack.makeConstraints { make in
            make.top.equalTo(hScrollView.topAnchor)
            make.bottom.equalTo(hScrollView.bottomAnchor)
            make.leading.equalTo(hScrollView.leadingAnchor)
            make.trailing.equalTo(hScrollView.trailingAnchor)
        }
        
        subscriptionView.makeConstraints { make in
            make.leading.equalTo(safeAreaLayoutGuide.leadingAnchor).offset(Constants.fieldStackViewLeadingOffset)
            make.trailing.equalTo(safeAreaLayoutGuide.trailingAnchor).offset(Constants.fieldStackViewTrailingOffset)
            make.top.equalTo(hStack.bottomAnchor).offset(24)
        }
        
        spacer.makeConstraints { make in
            make.top.equalTo(subscriptionView.bottomAnchor)
            make.bottom.equalTo(autoRenewableLabel.topAnchor)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        viewAllPlansButton.makeConstraints { make in
            make.centerY.equalTo(spacer.centerYAnchor).offset(-10)
            make.centerX.equalTo(safeAreaLayoutGuide.centerXAnchor)
        }
        
        autoRenewableLabel.makeConstraints { make in
            make.bottom.equalTo(tryFreeButton.topAnchor).offset(-16)
            make.centerX.equalTo(centerXAnchor)
        }
        
        tryFreeButton.makeConstraints { make in
            make.bottom.equalTo(registrationFooterView.topAnchor).offset(Constants.tryFreeButtonBottomOffset)
            make.leading.equalTo(safeAreaLayoutGuide.leadingAnchor).offset(Constants.fieldStackViewLeadingOffset)
            make.trailing.equalTo(safeAreaLayoutGuide.trailingAnchor).offset(Constants.fieldStackViewTrailingOffset)
            make.height.equalTo(Constants.tryFreeButtonHeight)
        }
        
        registrationFooterView.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.bottomAnchor)
            make.centerX.equalTo(centerXAnchor)
        }
    }
}

// MARK: - Constants

extension PaywallRootView {
    private enum Constants {
        static let navViewHeight: CGFloat = 198
        static let scrollViewTopOffset: CGFloat = 16
        static let scrollViewBottomOffset: CGFloat = -8
        static let fieldStackViewLeadingOffset: CGFloat = 16
        static let fieldStackViewTrailingOffset: CGFloat = -16
        static let tryFreeButtonBottomOffset: CGFloat = -16
        static let tryFreeButtonHeight: CGFloat = 48
        static let registrationFooterViewBottomOffset: CGFloat = -8
        static let registrationFooterViewLeadingOffset: CGFloat = 40
        static let registrationFooterViewTrailingOffset: CGFloat = -40
    }
}
