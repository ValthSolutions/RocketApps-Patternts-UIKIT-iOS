//
//  File.swift
//
//
//  Created by Alexandr Mefisto on 26.04.2023.
//

import UIKit

public final class Label: UILabel {
    
    public var textKey: String? 
    
    public init(
        text: String = "",
        textColor: UIColor = .black,
        font: UIFont? = UIFont.preferredFont(forTextStyle: .body),
        numberOfLines: Int = 1,
        alignment: NSTextAlignment = .natural,
        scaleFactor: CGFloat = 0.5) {
            super.init(frame: .zero)
            
            self.font = font ?? UIFont.preferredFont(forTextStyle: .body)
            self.text = text
            self.textColor = textColor
            self.numberOfLines = numberOfLines
            self.textAlignment = alignment
            backgroundColor = .clear
            minimumScaleFactor = scaleFactor
            adjustsFontSizeToFitWidth = true
        }
    
    public convenience init(
        textKey: String = "",
        textColor: UIColor = .black,
        font: UIFont? = UIFont.preferredFont(forTextStyle: .body),
        numberOfLines: Int = 1,
        alignment: NSTextAlignment = .natural) {
            
            self.init(text: "", textColor: textColor, font: font, numberOfLines: numberOfLines, alignment: alignment)
            self.textKey = textKey
        }
    
    public func appendText(_ additionalText: String) {
        if let currentText = self.text {
            self.text = currentText + additionalText
        } else {
            self.text = additionalText
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
