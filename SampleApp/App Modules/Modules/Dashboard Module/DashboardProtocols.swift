//
//  VCProtocols.swift
//  SampleApp
//
//  Created by Abhishek Srivastava on 29/05/22.
//

import Foundation
import SwiftCSV

// MARK: View Protocols
protocol DashboardInputDelegate {
    func stockTickerFetched()
    func horizontalNewsHeadlinesFetched()
    func verticleNewsListFetched()
}

// MARK: Interactor Protocols
protocol DashboardInteractorInpurDelegate {
    func getStockTickerData(fromRequest: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void)
    func getArticlesListData(fromRequest: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void)
}

// MARK: Presenter Protocols
// Presenter confirms view's delegate calls
protocol DashboardPresenterInputDelegate {
    // data requests
    func fetchStockTickerData()
    func fetchNewsData()
    func getStockTickerList() -> [StockTickerModel]?
    func getHorizontalNewsFeed() -> [Articles]?
    func getVerticalNewsFeed() -> [Articles]?
}
