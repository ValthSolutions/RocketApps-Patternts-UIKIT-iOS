
import UIKit
import Styling

class ViewController: UIViewController {
    
    let testButton = BaseButton(type: .system)
    let imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImageView_With_Blur()
    }
}

// MARK: BLUR
extension ViewController {
    private func setupImageView_With_Blur() {
        imageView.image = UIImage(named: "unsplash")
        imageView.contentMode = .scaleAspectFill
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
        
        let blurredSquare = BaseBlurredView(effect: .light)
        view.addSubview(blurredSquare)
        
        blurredSquare.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            blurredSquare.widthAnchor.constraint(equalToConstant: 300),
            blurredSquare.heightAnchor.constraint(equalToConstant: 300),
            blurredSquare.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            blurredSquare.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

// MARK: BUTTON
extension ViewController {
    private func setup1stButton() {
        setupConstraints()
        testButton.setTitle("Test Button", for: .normal)
        
        let buttonStyle = ButtonStyle(
            type: .primary(
                defaultColor: ColorScheme(light: .darkGray, dark: .lightGray),
                pressedColor: ColorScheme(light: .red, dark: .yellow),
                disabledColor: ColorScheme(light: .lightGray, dark: .darkGray)
            ),
            fontProfile: FontProfile(style: .title3Bold),
            icon: nil,
            effect:
                Effects(shadow: Shadow(color: .black,
                                       offset: CGSize(width: 0, height: 2),
                                       radius: 4, opacity: 0.2), cornerRadius: 8),
            spacing: .step5
        )
        
        testButton.decorate(with: buttonStyle)
    }
    
    private func setup2ndButton() {
        setupConstraints()
        testButton.setTitle("Test Button", for: .normal)
        
        let buttonStyle = ButtonStyle(
            type: .secondary(borderWidth: 4,
                             defaultBorderColor: ColorScheme(light: .darkGray, dark: .lightGray),
                             pressedBorderColor: ColorScheme(light: .red, dark: .yellow),
                             disabledBorderColor: ColorScheme(light: .lightGray, dark: .darkGray)
                            ),
            fontProfile: FontProfile(style: .largeTitle),
            icon: nil,
            effect:
                Effects(cornerRadius: 8)
        )
        
        testButton.decorate(with: buttonStyle)
    }
    
    private func setupConstraints() {
        view.addSubview(testButton)
        testButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            testButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            testButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            testButton.widthAnchor.constraint(equalToConstant: 200),
            testButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
