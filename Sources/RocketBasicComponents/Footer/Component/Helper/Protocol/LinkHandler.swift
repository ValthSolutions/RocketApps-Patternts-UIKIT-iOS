//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 03.10.2023.
//

import Foundation

public protocol LinkHandler: AnyObject {
    func handleLink(_ url: URL)
}
