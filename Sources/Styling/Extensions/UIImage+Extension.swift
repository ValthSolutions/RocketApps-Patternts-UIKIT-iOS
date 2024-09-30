import UIKit

#warning("TODO - why UIImage only?")
public extension UIImage {
    convenience init(color: UIColor, cornerRadius: CGFloat = 0, size: CGSize = CGSize(width: 1, height: 1)) {
        UIGraphicsBeginImageContext(size)
        color.setFill()
        let rect = CGRect(origin: .zero, size: size)
        if cornerRadius > 0 {
            UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).fill()
        } else {
            UIRectFill(rect)
        }
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.init(data: image.pngData()!)!
    }
}
