import UIKit
import Styling

open class BasePageControl: UIPageControl, Decoratable {
    
    public typealias Style = PageControlStyle
    
    public let padding: CGFloat = 1.5
    public let spacing: CGFloat = 10
    public let dotSize: CGFloat = 7
    public let strokeWidth: CGFloat = 1.0
    
    private var customLayers: [CAShapeLayer] = []
    private var style: Style = PageControlStyle()

    open func decorate(with style: Style) {
        self.style = style

        if let currentPageIndicatorTintColor = style.currentPageIndicatorTintColor {
            self.currentPageIndicatorTintColor = currentPageIndicatorTintColor.color
        }
        
        if let pageIndicatorTintColor = style.pageIndicatorTintColor {
            self.pageIndicatorTintColor = pageIndicatorTintColor.color
        }
    }
    
    open override var currentPage: Int {
        didSet {
            updateDots()
        }
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        updateDots()
    }
    
    private func updateDots() {
        customLayers.forEach { $0.removeFromSuperlayer() }
        customLayers.removeAll()
        
        let totalWidth = CGFloat(numberOfPages - 1) * spacing + CGFloat(numberOfPages) * dotSize
        let startX = (bounds.width - totalWidth) / 2
        
        for subview in subviews {
            subview.isHidden = true
        }
        
        for i in 0..<numberOfPages {
            let dotX = startX + CGFloat(i) * (dotSize + spacing)
            
            let dotRect = CGRect(x: dotX, y: (bounds.height - dotSize) / 2, width: dotSize, height: dotSize)
            
            let dotLayer = CAShapeLayer()
            dotLayer.path = UIBezierPath(ovalIn: dotRect).cgPath
            dotLayer.fillColor = (i == currentPage ? currentPageIndicatorTintColor : pageIndicatorTintColor)?.cgColor
            layer.addSublayer(dotLayer)
            customLayers.append(dotLayer)
            
            if i == currentPage && style.withCircle {
                let strokeLayer = CAShapeLayer()
                let strokeRect = dotRect.insetBy(dx: -(strokeWidth + padding), dy: -(strokeWidth + padding))
                strokeLayer.path = UIBezierPath(ovalIn: strokeRect).cgPath
                strokeLayer.fillColor = UIColor.clear.cgColor
                strokeLayer.strokeColor = currentPageIndicatorTintColor?.cgColor
                strokeLayer.lineWidth = strokeWidth
                layer.addSublayer(strokeLayer)
                customLayers.append(strokeLayer)
            }
        }
    }
}
