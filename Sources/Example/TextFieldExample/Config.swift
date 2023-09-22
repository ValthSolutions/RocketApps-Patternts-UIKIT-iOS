//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 22.09.2023.
//

import Foundation

struct EmailConfiguration: TextFieldConfiguration {
    let placeholderKey: String
    let topLabelKey: String
    
    var placeholder: String {
        return localized(placeholderKey)
    }
    
    var topLabel: String {
        return localized(topLabelKey)
    }
}

struct TextFieldConfigurationFactory {
    static func configuration(for type: InputFieldType) -> TextFieldConfiguration {
        switch type {
        case .email:
            return EmailConfiguration(placeholderKey: "placeholder_key",
                                      topLabelKey: "top_label_key")
        }
    }
}
