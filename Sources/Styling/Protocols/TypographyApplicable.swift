//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 21.09.2023.
//

import UIKit

public protocol TypographyApplicable {
    func applyTypography(fontFamily: String, style: Typography.Style, text: String)
}

public protocol TypographyButtonApplicable {
    func applyTypography(fontFamily: String, style: Typography.Style, text: String, forState state: UIControl.State)
}

public protocol TypographyTextFieldApplicable {
    func applyTypography(fontFamily: String, style: Typography.Style, text: String) -> NSAttributedString
}
