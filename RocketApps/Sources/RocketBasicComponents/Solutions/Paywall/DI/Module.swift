//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 28.09.2023.
//

import UIKit
import ApphudSDK

public struct Module {
    public static func buildPaywallModule(navigationController: UINavigationController
    ) -> IPaywallViewController {
        let router = PaywallRouter(navigationController: navigationController)
        let factory = PaywallFactory(router: router)
        let initialVC = factory.buildPaywallModule()
        return initialVC
    }
    
    func initializeApphud(with apiKey: String, userID: String? = "") {
        DispatchQueue.main.async {
            Apphud.enableDebugLogs()
            Apphud.start(apiKey: apiKey, userID: userID)
        }
    }
}
