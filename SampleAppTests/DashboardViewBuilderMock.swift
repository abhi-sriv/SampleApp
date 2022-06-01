//
//  DashboardViewBuilderMock.swift
//  SampleAppTests
//
//  Created by Abhishek Srivastava on 30/05/22.
//

import Foundation
import UIKit
@testable import SampleApp

class DashboardViewBuilderMock {
    func buildModule() -> DashboardViewController {
        let viewController = DashboardViewController.init(nibName: "DashboardViewController", bundle: nil)
        let interactor = DashboardInteractorMock()
        let presenter = DashboardPresenterMock()
        presenter.viewDelegate = viewController
        presenter.interactorDelegate = interactor
        viewController.presenterDelegate = presenter
        viewController.presenter = presenter
        let window = UIApplication.shared.keyWindow
        SampleAppBuilder().setRootViewController(initialVC: viewController, in: window)
        return viewController
    }
}
