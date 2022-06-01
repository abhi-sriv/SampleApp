//
//  SampleAppBuilder.swift
//  SampleApp
//
//  Created by Abhishek Srivastava on 28/05/22.
//

import Foundation
import UIKit

final class SampleAppBuilder {
    /// This method helps to setup Root VC
    /// - Parameter window: UIWindow object
    /// - Returns: default response
    @discardableResult
    func setRootViewController(initialVC: UIViewController, in window: UIWindow?) -> Bool {
        let navigationController = UINavigationController(rootViewController: initialVC)
        window?.rootViewController = navigationController
        
        //NOTE: Bring the window to the front of the screen
        window?.makeKeyAndVisible()
        return true
    }
}
