import UIKit
import Styling

open class BaseBlurredView: NiblessView {
    
    private var blurEffectView: UIVisualEffectView!
    
    public init(effect: UIBlurEffect.Style = .light) {
        super.init(frame: .zero)
        blurEffectView = self.addBlur(effectStyle: effect)
    }
    
    open func setOpacity(_ opacity: CGFloat) {
        self.alpha = opacity
    }
}
