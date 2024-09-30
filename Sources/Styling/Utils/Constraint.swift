//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 14.11.2023.
//

import UIKit

@propertyWrapper
public struct Constraint<T: UIView> {
    public var wrappedValue: T

    public init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
        self.wrappedValue.translatesAutoresizingMaskIntoConstraints = false
    }
}
