//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 28.09.2023.
//

import UIKit

public struct Module {
    public static func buildPaywallModule(navigationController: UINavigationController
    ) -> IPaywallViewController {
        let router = PaywallRouter(navigationController: navigationController)
        let factory = PaywallFactory(router: router)
        let initialVC = factory.buildPaywallModule()
        return initialVC
    }
}
