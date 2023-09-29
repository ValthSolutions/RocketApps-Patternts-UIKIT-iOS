import UIKit
import Styling

open class PlansRootView: NiblessView {
    
    // MARK: - Properties
    
    private(set) lazy var chooseButton = BaseButton()
    private(set) lazy var chooseButtonTapped = createButtonTapPublisher(for: chooseButton)
    
    private(set) lazy var vStack: UIStackView = {
        $0.spacing = Spacing.step5.rawValue
        $0.alignment = .center
        $0.axis = .vertical
        return $0
    }(UIStackView())
    
    private let registrationFooterView = RegistrationFooterView()
    private let cancelAnyTimeLabel = BaseLabel()
    private let chooseThePlanLabel = BaseLabel()

    // MARK: - Init
    
    public init() {
        super.init(frame: .zero)
        setupUI()
    }
}

// MARK: - Private

extension PlansRootView {
    private func setupUI() {
        backgroundColor = .white
        setupHierarchy()
        setupConstraints()
        registrationFooterView.decorate(with: .init())
        
        let buttonStyles = Skeleton.ButtonStyles.chooseStyle
        chooseButton.setTitle(buttonStyles.0, for: .normal)
        chooseButton.decorate(with: buttonStyles.1)
        
        let labelStyle1 = Skeleton.LabelStyles.autoRenewable
        cancelAnyTimeLabel.text = "No obligations. Cancel anytime"
        cancelAnyTimeLabel.decorate(with: labelStyle1.1)
        
        let labelStyle2 = Skeleton.LabelStyles.chooseThePlan
        chooseThePlanLabel.text = labelStyle2.0
        chooseThePlanLabel.decorate(with: labelStyle2.1)
    }
    
    @objc private func dismissKeyboard() {
        endEditing(true)
    }
}

// MARK: - Hierarchy

extension PlansRootView {
    private func setupHierarchy() {
        addSubview(vStack)
        addSubview(registrationFooterView)
        addSubview(chooseButton)
        addSubview(chooseThePlanLabel)
        addSubview(cancelAnyTimeLabel)

        //TEST
        let previewSubscriptionViews: [SubscriptionView] = [
            SubscriptionView(topText: "Annual", priceText: "$39.99", bottomText: "Free 7 days free trial. Billed yearly after free trial."),
            SubscriptionView(topText: "Annual", priceText: "$39.99", bottomText: "Free 7 days free trial. Billed yearly after free trial."),
            SubscriptionView(topText: "Annual", priceText: "$39.99", bottomText: "Free 7 days free trial. Billed yearly after free trial.")
        ]
        previewSubscriptionViews.forEach {
            $0.decorate(with: .default)
            vStack.addArrangedSubview($0)
            $0.makeConstraints { make in
                make.leading.equalTo(leadingAnchor).offset(16)
                make.trailing.equalTo(trailingAnchor).offset(-16)
            }
        }
    }
}

// MARK: - Constraints

extension PlansRootView {
    private func setupConstraints() {
        
        
        chooseThePlanLabel.makeConstraints { make in
            make.bottom.equalTo(cancelAnyTimeLabel.topAnchor).offset(-12)
            make.centerX.equalTo(centerXAnchor)
        }
        
        cancelAnyTimeLabel.makeConstraints { make in
            make.bottom.equalTo(vStack.topAnchor).offset(-30)
            make.centerX.equalTo(centerXAnchor)
        }
        
        vStack.makeConstraints { make in
            make.bottom.equalTo(chooseButton.topAnchor).offset(-80)
            make.leading.equalTo(leadingAnchor).offset(16)
            make.trailing.equalTo(trailingAnchor).offset(-16)
        }
        
        chooseButton.makeConstraints { make in
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

extension PlansRootView {
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
