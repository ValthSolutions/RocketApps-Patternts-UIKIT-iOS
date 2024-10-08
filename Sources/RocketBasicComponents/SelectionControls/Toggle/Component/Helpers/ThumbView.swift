import UIKit
import Styling

open class ThumbView: NiblessView {
    
    fileprivate(set) var thumbImageView = UIImageView(frame: CGRect.zero)
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.thumbImageView)
    }
}

extension ThumbView {
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.thumbImageView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        self.thumbImageView.layer.cornerRadius = self.layer.cornerRadius
        self.thumbImageView.clipsToBounds = self.clipsToBounds
    }
}
