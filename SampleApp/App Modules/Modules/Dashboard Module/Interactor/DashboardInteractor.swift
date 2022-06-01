//
//  DashboardInteractor.swift
//  SampleApp
//
//  Created by Abhishek Srivastava on 29/05/22.
//

import Foundation


class DashboardInteractor: DashboardInteractorInpurDelegate {
   
    private let dispatchGroup = DispatchGroup()

    func getStockTickerData(fromRequest: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        dispatchGroup.enter()
        NetworkManager.sharedManager.getDataFor(request: fromRequest) {[unowned self] data, response, error in
            DispatchQueue.main.async {
                self.dispatchGroup.leave()
            }
            completionHandler(data, response, error)
        }
    }
    
    func getArticlesListData(fromRequest: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        dispatchGroup.enter()
        NetworkManager.sharedManager.getDataFor(request: fromRequest) {[unowned self] data, response, error in
            DispatchQueue.main.async {
                self.dispatchGroup.leave()
            }
            completionHandler(data, response, error)
        }
    }
    
    
    
}
