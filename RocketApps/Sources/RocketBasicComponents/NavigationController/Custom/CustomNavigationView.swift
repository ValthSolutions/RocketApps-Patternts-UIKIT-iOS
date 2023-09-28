import UIKit
import LayoutKit
import Styling

public final class CustomNavigationView: NiblessView {
    
    // MARK: - Properties
    
    private let topTextKey: String
    private let bottomTextKey: String
    
    private(set) lazy var topLabel = Label(
        textKey: topTextKey,
        textColor: .white,
        font: .systemFont(ofSize: 10),
        alignment: .left)
    
    private(set) lazy var bottomLabel = Label(
        textKey: bottomTextKey,
        textColor: .white,
        font: .systemFont(ofSize: 10),
        numberOfLines: 0,
        alignment: .left)
    
    // MARK: - Init
    
    public init(
        topTextKey: String,
        bottomTextKey: String
    ) {
        self.topTextKey = topTextKey
        self.bottomTextKey = bottomTextKey
        super.init(frame: .zero)
        setupUI()
        bottomLabel.adjustsFontSizeToFitWidth = false
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        setupRoundedCorners()
    }
    
    private func setupUI() {
        setupHierarchy()
        setupConstraints()
        backgroundColor = .blue
    }
}

// MARK: - Hierarchy

extension CustomNavigationView {
    func setupHierarchy() {
        [topLabel, bottomLabel].forEach {
            addSubview($0)
        }
    }
}

// MARK: - Constraints

extension CustomNavigationView {
    func setupConstraints() {
        topLabel.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.topAnchor)
            make.leading.equalTo(leadingAnchor).offset(16)
            make.trailing.equalTo(trailingAnchor).offset(-16)
        }
        
        bottomLabel.makeConstraints { make in
            make.top.equalTo(topLabel.bottomAnchor)
            make.leading.equalTo(topLabel.leadingAnchor)
            make.trailing.equalTo(topLabel.trailingAnchor)
            make.bottom.equalTo(bottomAnchor).offset(-16)
        }
    }
}

// MARK: - Rounded corners

extension CustomNavigationView {
    func setupRoundedCorners() {
        let maskLayer = CAShapeLayer()
        let path = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: [.bottomLeft, .bottomRight],
                                cornerRadii: CGSize(width: 12, height: 12))
        maskLayer.path = path.cgPath
        layer.mask = maskLayer
    }
}
