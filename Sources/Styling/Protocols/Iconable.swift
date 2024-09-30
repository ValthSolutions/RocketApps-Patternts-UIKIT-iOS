import UIKit

public protocol Iconable {
    func setIcon(_ image: UIImage)
    func setIconTintColor(_ color: ColorScheme)
    func setIconVisibility(_ isVisible: Bool)
}
