import Foundation

public struct EdgeSpacing {
    public var top: CGFloat
    public var bottom: CGFloat
    public var leading: CGFloat
    public var trailing: CGFloat
    
    public init(top: CGFloat = 10,
                bottom: CGFloat = 10,
                leading: CGFloat = 10,
                trailing: CGFloat = 10
    ) {
        self.top = top
        self.bottom = bottom
        self.leading = leading
        self.trailing = trailing
    }
    
    static let zero = EdgeSpacing()
}
