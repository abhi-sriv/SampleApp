//
//  DashboardViewBuilder.swift
//  SampleApp
//
//  Created by Abhishek Srivastava on 29/05/22.
//

import Foundation
import UIKit


final class DashboardViewBuilder {
    
    func buildModule() -> DashboardViewController {
        let viewController: DashboardViewController = DashboardViewController.init(nibName: "DashboardViewController", bundle: nil)
        let interactor = DashboardInteractor()
        let presenter = DashboardPresenter()
        presenter.viewDelegate = viewController
        presenter.interactorDelegate = interactor
        viewController.presenterDelegate = presenter
        viewController.presenter = presenter
        return viewController
    }
}
