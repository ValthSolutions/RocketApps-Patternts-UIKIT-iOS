import UIKit
import Styling

open class PaywallRootView: NiblessView {
    
    // MARK: - Properties
    
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
    
    private let scrollView: UIScrollView = {
        $0.showsHorizontalScrollIndicator = false
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIScrollView())
    
    private let registrationFooterView = RegistrationFooterView()
    
    private let autoRenewableLabel = BaseLabel()
    private let navigationView = CustomNavigationView()
    
    // MARK: - Init
    
    public init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        scrollView.contentInset = UIEdgeInsets(top: 16, left: 16, bottom: 30, right: 16 + 30)
    }
}

// MARK: - Private

extension PaywallRootView {
    private func setupUI() {
        backgroundColor = .white
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .clear
        setupHierarchy()
        setupConstraints()
        registrationFooterView.decorate(with: .init())
        
        navigationView.setTitle("Get full access to Floro Premium")
        navigationView.decorate(with: .default)
        
        let buttonStyles = Skeleton.ButtonStyles.primary
        tryFreeButton.setTitle(buttonStyles.0, for: .normal)
        tryFreeButton.decorate(with: buttonStyles.1)
        
        let labelStyles = Skeleton.LabelStyles.autoRenewable
        autoRenewableLabel.text = labelStyles.0
        autoRenewableLabel.decorate(with: labelStyles.1)
        
        let viewAllPlansStyle = Skeleton.ButtonStyles.viewAllPlans
        viewAllPlansButton.setTitle(viewAllPlansStyle.0, for: .normal)
        viewAllPlansButton.decorate(with: viewAllPlansStyle.1)
        
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
        addSubview(scrollView)
        scrollView.addSubview(hStack)
        addSubview(registrationFooterView)
        addSubview(tryFreeButton)
        addSubview(viewAllPlansButton)
        addSubview(autoRenewableLabel)
        addSubview(navigationView)
    }
}

// MARK: - Constraints

extension PaywallRootView {
    private func setupConstraints() {
        navigationView.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(leadingAnchor)
            make.trailing.equalTo(trailingAnchor)
            make.height.equalTo(heightAnchor, multiplier: 0.33)
        }
        
        scrollView.makeConstraints { make in
            make.top.equalTo(navigationView.bottomAnchor)
            make.bottom.equalTo(viewAllPlansButton.topAnchor)
            make.leading.equalTo(leadingAnchor)
            make.trailing.equalTo(trailingAnchor)
        }
        
        hStack.makeConstraints { make in
            make.top.equalTo(scrollView.topAnchor)
            make.bottom.equalTo(scrollView.bottomAnchor)
            make.leading.equalTo(scrollView.leadingAnchor)
            make.trailing.equalTo(scrollView.trailingAnchor)
        }
        
        viewAllPlansButton.makeConstraints { make in
            make.bottom.equalTo(autoRenewableLabel.bottomAnchor).offset(-38)
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
