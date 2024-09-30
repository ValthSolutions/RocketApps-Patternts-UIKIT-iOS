//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 03.10.2023.
//

import Foundation
import SafariServices

extension UIViewController: LinkHandler {
    public func handleLink(_ url: URL) {
        let safariViewController = SFSafariViewController(url: url)
        present(safariViewController, animated: true, completion: nil)
    }
}
