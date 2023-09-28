//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 21.09.2023.
//

import UIKit

public protocol TypographyApplicable {
    func applyTypography(_ profile: FontProfile)
}

public protocol TypographyButtonApplicable where Self: UIButton {
    func applyTypography(fontFamily: String, style: Typography.Style, text: String, forState state: UIControl.State)
}

public protocol TypographyTextFieldApplicable {
    func applyTypography(_ profile: FontProfile) 
    func applyTypographyForPlaceholder(_ profile: FontProfile)
}
