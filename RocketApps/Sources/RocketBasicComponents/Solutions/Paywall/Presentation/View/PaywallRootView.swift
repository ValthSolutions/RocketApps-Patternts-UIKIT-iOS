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
    
    private let scrollView: UIScrollView = UIScrollView()
    
    private let registrationFooterView = RegistrationFooterView()
    
    private let autoRenewableLabel = BaseLabel()
    private let navigationView = CustomNavigationView(
        topTextKey: "Get full access",
        bottomTextKey: "to Floro Premium")
    
    // MARK: - Init
    
    public init() {
        super.init(frame: .zero)
        setupUI()
    }
}

// MARK: - Private

extension PaywallRootView {
    private func setupUI() {
        backgroundColor = .white
        scrollView.showsVerticalScrollIndicator = false
        setupHierarchy()
        setupConstraints()
        registrationFooterView.decorate(with: .init())
        
        let buttonStyles = Skeleton.ButtonStyles.primary
        tryFreeButton.setTitle(buttonStyles.0, for: .normal)
        tryFreeButton.decorate(with: buttonStyles.1)
        
        let labelStyles = Skeleton.LabelStyles.autoRenewable
        autoRenewableLabel.text = labelStyles.0
        autoRenewableLabel.decorate(with: labelStyles.1)
        
        let viewAllPlansStyle = Skeleton.ButtonStyles.viewAllPlans
        viewAllPlansButton.setTitle(viewAllPlansStyle.0, for: .normal)
        viewAllPlansButton.decorate(with: viewAllPlansStyle.1)
    }
    
    private func setupViewStack() {
        
    }
    
    @objc private func dismissKeyboard() {
        endEditing(true)
    }
}

// MARK: - Hierarchy

extension PaywallRootView {
    private func setupHierarchy() {
//        addSubview(scrollView)
        //        scrollView.addSubview(fieldStackView)
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
//
//        scrollView.makeConstraints { make in
//            make.top.equalTo(navigationView.bottomAnchor).offset(Constants.scrollViewTopOffset)
//            make.bottom.equalTo(tryFreeButton.topAnchor).offset(Constants.scrollViewBottomOffset)
//            make.leading.equalTo(safeAreaLayoutGuide.leadingAnchor)
//            make.trailing.equalTo(safeAreaLayoutGuide.trailingAnchor)
//        }
//
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
