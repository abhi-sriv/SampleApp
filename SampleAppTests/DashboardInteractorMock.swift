//
//  DashboardInteractorMock.swift
//  SampleAppTests
//
//  Created by Abhishek Srivastava on 30/05/22.
//

import Foundation
@testable import SampleApp

class DashboardInteractorMock: DashboardInteractor {
    override func getStockTickerData(fromRequest: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let bundle = Bundle(for: type(of: self))
        guard let fileUrl = bundle.url(forResource: "StockTickerAPIResponse", withExtension: "csv") else {
            debugPrint("Failed load the CSV file")
            return
        }
        do {
            let data = try Data(contentsOf: fileUrl)
            completionHandler(data, nil, nil)
        } catch {
            assertionFailure("Failed load the CSV file")
        }
    }
    
    override func getArticlesListData(fromRequest: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let bundle = Bundle(for: type(of: self))
        guard let fileUrl = bundle.url(forResource: "ArticlesAPIResponse", withExtension: "json") else {
            debugPrint("Failed load the json file")
            return
        }
        do {
            let data = try Data(contentsOf: fileUrl)
            completionHandler(data, nil, nil)
        } catch {
            assertionFailure("Failed load the json file")
        }
    }
}
