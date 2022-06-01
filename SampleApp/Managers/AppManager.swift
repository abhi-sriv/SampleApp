//
//  AppManager.swift
//  SampleApp
//
//  Created by Abhishek Srivastava on 28/05/22.
//

import Foundation
import UIKit

final class AppManager: NSObject {
    
    static let shared: AppManager = AppManager()
    private static var alertController = UIAlertController(title: "Error", message: "", preferredStyle: .alert)
    private static let action = UIAlertAction(title: "Ok", style: .cancel, handler: { _ in
        DispatchQueue.main.async {
            AppManager.alertController.dismiss(animated: false, completion: nil)
        }
    })
    //Singleton objects will need a private init to avoid being initialised from outside
    private override init() {}
    
    /// Use this function to show an error across the app
    /// - Parameter message: The message that need to be displayed on the UIAlertViewController
    func showError(withMessage message: String) {
        DispatchQueue.main.async {
            AppManager.alertController.message = message
            if !AppManager.alertController.isBeingPresented {
                if !AppManager.alertController.actions.contains(AppManager.action) {
                    AppManager.alertController.addAction(AppManager.action)
                }
                if let topVC = AppManager.topViewController() {
                    topVC.present(AppManager.alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    /// Get the UIViewController object that is currently being displayed on the screen
    /// - Parameter controller: Optional UIViewController that you can pass to determine the type of the controller it is. eg, UINavigationController or UITabBarViewController
    /// - Returns: Returns the UIViewController object that is displayed on screen.
    class func topViewController(controller: UIViewController? = UIApplication.shared.windows.first { $0.isKeyWindow }?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        else if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        else if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
    
    func removeDuplicates(_ arrayOfStr: [[String]]) -> [StockTickerModel] {
        var uniqueDict: Dictionary<String, Double> = Dictionary()
        for arrObj in arrayOfStr {
            uniqueDict.updateValue(Double(arrObj[1]) ?? 0.0, forKey: arrObj[0])
        }
        var tickerModelList: [StockTickerModel] = []
        for tickerObj in uniqueDict {
            let ticker: StockTickerModel = StockTickerModel(stockName: tickerObj.key, stockPrice: tickerObj.value)
            tickerModelList.append(ticker)
        }
        tickerModelList.sort(by: { $0.stockName < $1.stockName} )
        return tickerModelList
    }
}
