import UIKit
import Styling

open class CustomNavigationViewStyle {
    var labelStyle: LabelStyle?
    var backgroundImage: UIImage?
    
    public init(
        labelStyle: LabelStyle? = nil,
        backgroundImage: UIImage? = nil
    ) {
        self.labelStyle = labelStyle
        self.backgroundImage = backgroundImage
    }
}

extension CustomNavigationViewStyle {
    public static var `default`: CustomNavigationViewStyle {
        return CustomNavigationViewStyle(
            labelStyle: LabelStyle(fontProfile: FontProfile(style: .largeTitle),
                                   textColor: .init(ColorScheme(light: .white, dark: .white))),
            backgroundImage: UIImage(named: "floro", in: StylingResource.bundle, with: .none)
        )
    }
}
