//
//  Constants.swift
//  SampleApp
//
//  Created by Abhishek Srivastava on 29/05/22.
//

import Foundation

struct Constants {
    //URLs
    static let articlesURL = "https://saurav.tech/NewsAPI/everything/cnn.json"
    static let stockTickerURL = "https://raw.githubusercontent.com/dsancov/TestData/main/stocks.csv"
    
    //Cell IDs
    static let headerID = "HeaderID"
    static let stockTickerCellID = "StockTickerCollectionViewCell"
    static let headlinesCellID = "HeadlinesCollectionViewCell"
    static let newsCellID = "NewsCollectionViewCell"
    
    //Errors
    static let generalizedError = "An Error occured while processing. Please try again"
    
}
