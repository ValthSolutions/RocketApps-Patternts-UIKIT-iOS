import UIKit

public protocol Dequeuable {
    static var dequeuIdentifier: String { get }
}

extension Dequeuable where Self: UIView {
    public static var dequeuIdentifier: String {
        return String(describing: self)
    }
}
