//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 14.11.2023.
//

import UIKit

@propertyWrapper
public struct LazyConstraint<T: UIView> {
    public lazy var wrappedValue: T = {
        let view = T()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    public init() {}
}
