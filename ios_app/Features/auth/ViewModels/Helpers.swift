//
//  Helpers.swift
//  ios_app
//
//  Created by Wilson Overfield on 12/30/24.
//

import Foundation
import UIKit

extension UIApplication {

    /// Recursively retrieves the top-most view controller in the view hierarchy.
    /// - Parameter base: The starting point of the view hierarchy (default is the root view controller).
    /// - Returns: The top-most `UIViewController` or `nil` if none exists.
    class func getTopViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        // If the base is a navigation controller, get its currently visible view controller
        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)

        // If the base is a tab bar controller, get the currently selected view controller
        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewController(base: selected)

        // If the base has a presented view controller, get the presented view controller
        } else if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }

        // If none of the above, return the base itself
        return base
    }
}
