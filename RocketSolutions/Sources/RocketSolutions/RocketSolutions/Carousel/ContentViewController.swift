import UIKit

class ContentViewController: UIViewController {
    var imageView: UIImageView = .init()
    
    var contentImage: UIImage? {
        didSet {
            imageView.image = contentImage
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImageView()
    }
    
    private func setupImageView() {
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode = .scaleAspectFit
        imageView.image = contentImage
        view.addSubview(imageView)
    }
}
