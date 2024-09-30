public protocol Decoratable {
    associatedtype Style
    func decorate(with style: Style)
}
