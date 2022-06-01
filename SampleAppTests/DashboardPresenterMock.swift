//
//  DashboardPresenterMock.swift
//  SampleAppTests
//
//  Created by Abhishek Srivastava on 30/05/22.
//

import Foundation
@testable import SampleApp

class DashboardPresenterMock : DashboardPresenter {
    private func getCSVData(completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        if let csvMockURL = URL.init(string: "mockCSV.url") {
            let csvMockRequest = URLRequest.init(url: csvMockURL)
            self.interactorDelegate?.getStockTickerData(fromRequest: csvMockRequest) { data, response, error in
                completionHandler(data, response, error)
            }
        }
    }
    
    private func getNewsData(completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        if let newsMockURL = URL.init(string: "newsMock.url") {
            let newsMockRequest = URLRequest.init(url: newsMockURL)
            self.interactorDelegate?.getArticlesListData(fromRequest: newsMockRequest) { data, response, error in
                completionHandler(data, response, error)
            }
        }
    }
}
