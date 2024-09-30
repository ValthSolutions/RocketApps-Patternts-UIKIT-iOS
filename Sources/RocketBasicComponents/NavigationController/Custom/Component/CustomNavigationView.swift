import UIKit
import LayoutKit
import Styling

open class CustomNavigationView: NiblessView,
                                         Decoratable {
    
    public typealias Style = CustomNavigationViewStyle
    
    // MARK: - Properties
    
    private let imageView = UIImageView()
    
    private(set) lazy var topLabel = BaseLabel()
    // MARK: - Init
    
    public init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        setupRoundedCorners()
    }
    
    open func setTitle(_ topText: String) {
        topLabel.text = topText
    }
    
    open func decorate(with style: CustomNavigationViewStyle) {
        if let labelStyle = style.labelStyle {
            topLabel.decorate(with: labelStyle)
            topLabel.numberOfLines = 0
        }
        
        if let image = style.backgroundImage {
            imageView.image = image
        }
    }
    
    private func setupUI() {
        setupHierarchy()
        setupConstraints()
        imageView.sizeToFit()
    }
}

// MARK: - Hierarchy

extension CustomNavigationView {
    func setupHierarchy() {
        addSubview(topLabel)
        insertSubview(imageView, belowSubview: topLabel)
    }
}

// MARK: - Constraints

extension CustomNavigationView {
    func setupConstraints() {
        imageView.setEdges()
        
        topLabel.makeConstraints { make in
            make.bottom.equalTo(bottomAnchor).offset(-24)
            make.leading.equalTo(leadingAnchor).offset(16)
            make.trailing.equalTo(trailingAnchor).offset(-16)
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
