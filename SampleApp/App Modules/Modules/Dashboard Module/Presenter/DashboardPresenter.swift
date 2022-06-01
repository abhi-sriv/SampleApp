//
//  DashboardPresenter.swift
//  SampleApp
//
//  Created by Abhishek Srivastava on 29/05/22.
//

import Foundation
import SwiftCSV


class DashboardPresenter: NSObject {
    
    override init() { }
    
    var interactorDelegate: DashboardInteractorInpurDelegate? = nil
    var viewDelegate: DashboardInputDelegate? = nil
    private var csvList: CSV? = nil
    private var stockTickerList: [StockTickerModel]? = nil
    private(set) var articlesList: [Articles]? = nil
    private weak var timer: Timer?
    
    /* Ideally the requests can be quite complicated, with each request having a different header and body and types like Get, Put, Post, Delete */
    private func getStockTickerData(completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        if let articleUrl = URL.init(string: Constants.stockTickerURL) {
            let articleRequest = URLRequest.init(url: articleUrl)
            self.interactorDelegate?.getStockTickerData(fromRequest: articleRequest, completionHandler: { data, response, error in
                completionHandler(data, response, error)
            })
        }
    }
    
    private func getArticlesListData(completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        if let stockTickerUrl = URL.init(string: Constants.articlesURL) {
            let stockTickerRequest = URLRequest.init(url: stockTickerUrl)
            self.interactorDelegate?.getArticlesListData(fromRequest: stockTickerRequest, completionHandler: { data, response, error in
                completionHandler(data, response, error)
            })
        }
    }
    
    private func handleErrors(error: Error? = nil) {
        if let err = error as? URLError {
            // We can add specific error checks here like No internet with "err.code == URLError.Code.notConnectedToInternet".
            AppManager.shared.showError(withMessage: err.localizedDescription)
        } else {
            AppManager.shared.showError(withMessage: Constants.generalizedError)
        }
    }
    
    deinit {
        self.stopTimer()
    }
}


extension DashboardPresenter: DashboardPresenterInputDelegate {
    
    func fetchStockTickerData() {
        self.getStockTickerData { data, request, error in
            guard let csvData = data, error == nil else {
                self.handleErrors(error: error)
                return
            }
            let csvStr = String(decoding: csvData, as: UTF8.self)
            do {
                let csv = try CSV.init(string: csvStr, delimiter: ",")
                self.csvList = csv
                self.updatedTicker()
                DispatchQueue.main.async {
                    self.viewDelegate?.stockTickerFetched()
                    let ncTimer = Timer(timeInterval: 2.0, target: self, selector: #selector(self.updatedTicker), userInfo: nil, repeats: true)
                    RunLoop.main.add(ncTimer, forMode: RunLoop.Mode.default)
                }
            } catch {
                self.handleErrors()
            }
        }
    }
    
    func fetchNewsData() {
        self.getArticlesListData { data, response, error in
            let jsonDecoder = JSONDecoder()
            guard let jsonData = data, error == nil else {
                self.handleErrors(error: error)
                return
            }
            do {
                let articlesList = try jsonDecoder.decode(ArticlesListModel.self, from: jsonData)
                self.articlesList = articlesList.articles
                DispatchQueue.main.async {
                    self.viewDelegate?.horizontalNewsHeadlinesFetched()
                    self.viewDelegate?.verticleNewsListFetched()
                }
            } catch {
                self.handleErrors()
            }
        }
    }
    
    func getStockTickerList() -> [StockTickerModel]? {
        return self.stockTickerList
    }
    
    @objc private func updatedTicker() {
        DispatchQueue.main.async {
            guard let tickerArray = self.csvList?.enumeratedRows, tickerArray.count > 0 else {return}
            let tickers = AppManager.shared.removeDuplicates(tickerArray.shuffled())
            self.stockTickerList = tickers
            self.viewDelegate?.stockTickerFetched()
        }
    }
    
    func getHorizontalNewsFeed() -> [Articles]? {
        if let articles = self.articlesList {
            // For horizontal headlines view return first 6 objects if listcount is > 6
            let headlines = (articles.count >= 6) ? Array(articles.prefix(6)) : articles
            return headlines
        }
        return nil
    }
    
    func getVerticalNewsFeed() -> [Articles]? {
        // Since first 6 Articles will be used as headlines, return the remaining as a verticle list.
        if let articles = self.articlesList, articles.count > 5 {
            return Array(articles.dropFirst(6))
        }
        return nil
    }
    
    func stopTimer() {
        self.timer?.invalidate()
    }
}
