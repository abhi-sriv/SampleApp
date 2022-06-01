//
//  DashboardViewControllerTests.swift
//  SampleAppTests
//
//  Created by Abhishek Srivastava on 30/05/22.
//

import XCTest
@testable import SampleApp

class DashboardViewControllerTests: XCTestCase {
    var viewController: DashboardViewController?
    var stockTickerExpectation: XCTestExpectation?
    var headlinesTickerExpectation: XCTestExpectation?
    var newsTickerExpectation: XCTestExpectation?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.viewController = DashboardViewBuilderMock().buildModule()
        self.viewController?.presenter?.viewDelegate = self
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.viewController = nil
        self.viewController?.presenter?.viewDelegate = nil
    }
    
    func testStockTickerData() {
        self.viewController?.presenterDelegate?.fetchStockTickerData()
        self.stockTickerExpectation = expectation(description: "StockTicker")
        waitForExpectations(timeout: 20)
        let cell = self.viewController?.collectionView.cellForItem(at: IndexPath.init(item: 0, section: 0)) as? StockTickerCollectionViewCell
        XCTAssert(cell?.stockNameLabel.text == "AAPL", "The stock name should match to AAPL")
    }
    
    func testHeadLinesData() {
        self.viewController?.presenterDelegate?.fetchNewsData()
        self.headlinesTickerExpectation = expectation(description: "Headlines")
        waitForExpectations(timeout: 20)
        let cell = self.viewController?.collectionView(self.viewController?.collectionView ?? UICollectionView(), cellForItemAt: IndexPath.init(item: 0, section: 0)) as? HeadlinesCollectionViewCell
        let newsTitle = "'God needs to come and explain it': How the football world reacted to Real Madrid's extraordinary Champions League semifinal victory"
        XCTAssert(cell?.newsTitleLabel.text == newsTitle, "The news title should match with \(newsTitle)")
    }
    
    func testNewsData() {
        self.viewController?.presenterDelegate?.fetchNewsData()
        self.newsTickerExpectation = expectation(description: "News")
        waitForExpectations(timeout: 20)
        let cell = self.viewController?.collectionView.cellForItem(at: IndexPath.init(item: 0, section: 0)) as? NewsCollectionViewCell
        let newsTitle = "Rock climbing brings unexpected benefits"
        XCTAssert(cell?.newsTitleLabel.text == newsTitle, "The news title should match with \(newsTitle)")
    }
    
}

extension DashboardViewControllerTests: DashboardInputDelegate {
    func stockTickerFetched() {
        self.viewController?.collectionView.performBatchUpdates {
            self.viewController?.collectionView.reloadSections(IndexSet.init(integer: 0))
        }
        if self.stockTickerExpectation != nil { self.stockTickerExpectation?.fulfill() }
    }
    
    func horizontalNewsHeadlinesFetched() {
        self.viewController?.collectionView.performBatchUpdates {
            self.viewController?.collectionView.reloadSections(IndexSet.init(integer: 1))
        }
        if self.headlinesTickerExpectation != nil { self.headlinesTickerExpectation?.fulfill() }
    }
    
    func verticleNewsListFetched() {
        self.viewController?.collectionView.performBatchUpdates {
            self.viewController?.collectionView.reloadSections(IndexSet.init(integer: 2))
        }
        if self.newsTickerExpectation != nil { self.newsTickerExpectation?.fulfill() }
    }
}





