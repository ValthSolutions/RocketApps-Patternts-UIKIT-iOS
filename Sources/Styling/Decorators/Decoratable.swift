//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 18.09.2023.
//

public protocol Decoratable: Colorable, Iconable {
    associatedtype Style
    func decorate(with style: Style)
}
