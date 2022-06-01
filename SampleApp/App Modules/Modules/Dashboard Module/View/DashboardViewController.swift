//
//  DashboardViewController.swift
//  SampleApp
//
//  Created by Abhishek Srivastava on 28/05/22.
//

import UIKit
import SwiftCSV

class DashboardViewController: UIViewController {
    
    //Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    //Properties
    var presenter: DashboardPresenter? = nil
    var presenterDelegate: DashboardPresenterInputDelegate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpCollectionview()
        self.getData()
    }

    func setUpCollectionview () {
        UIView.setAnimationsEnabled(false)
        self.collectionView.collectionViewLayout = self.createLayout()
        self.collectionView.register(UINib.init(nibName: Constants.stockTickerCellID, bundle: nil), forCellWithReuseIdentifier: Constants.stockTickerCellID)
        self.collectionView.register(UINib.init(nibName: Constants.headlinesCellID, bundle: nil), forCellWithReuseIdentifier: Constants.headlinesCellID)
        self.collectionView.register(UINib.init(nibName: Constants.newsCellID, bundle: nil), forCellWithReuseIdentifier: Constants.newsCellID)

        self.collectionView.register(DashboardCollectionViewSectionHeader.self, forSupplementaryViewOfKind: Constants.headerID, withReuseIdentifier: Constants.headerID)
    }
    
    func getData() {
        self.presenterDelegate?.fetchStockTickerData()
        self.presenterDelegate?.fetchNewsData()
    }
}

extension DashboardViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Constants.headerID, for: indexPath) as? DashboardCollectionViewSectionHeader else { return UICollectionReusableView() }
        if indexPath.section == 0 {
            header.sectionTitleLabel.text = "Market Watch"
        } else if indexPath.section == 1 {
            header.sectionTitleLabel.text = "Headlines"
        } else {
            header.sectionTitleLabel.text = "Other News"
        }
        return header
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            let count = self.presenterDelegate?.getStockTickerList()?.count ?? 0
            return count
        } else if section == 1 {
            let count = self.presenterDelegate?.getHorizontalNewsFeed()?.count ?? 0
            return count
        }
        let count = self.presenterDelegate?.getVerticalNewsFeed()?.count ?? 0
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.stockTickerCellID, for: indexPath) as? StockTickerCollectionViewCell else { return UICollectionViewCell() }
            let tickerList = self.presenterDelegate?.getStockTickerList()
            if let tickerObj = tickerList?[indexPath.row] {
                cell.configureCell(tickerObj: tickerObj)
            }
            return cell
        } else if indexPath.section == 1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.headlinesCellID, for: indexPath) as? HeadlinesCollectionViewCell else { return UICollectionViewCell() }
            if let headlinesList = self.presenterDelegate?.getHorizontalNewsFeed() {
                let headlinesObj: Articles = headlinesList[indexPath.row]
                cell.configureCell(articleObj: headlinesObj)
            }

            return cell
        } else if indexPath.section == 2 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.newsCellID, for: indexPath) as? NewsCollectionViewCell else { return UICollectionViewCell() }
            if let headlinesList = self.presenterDelegate?.getVerticalNewsFeed() {
                let headlinesObj: Articles = headlinesList[indexPath.row]
                cell.configureCell(articleObj: headlinesObj)
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            if sectionNumber == 0 {
                // Stock Ticker
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1)))
                item.contentInsets.trailing = 15
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.8), heightDimension: .absolute(60)), subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
                section.contentInsets.leading = 15
                section.boundarySupplementaryItems = [
                    .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: Constants.headerID, alignment: .topLeading)
                ]
                return section
            } else if sectionNumber == 1 {
                //Headlines
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                item.contentInsets.trailing = 16
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.93), heightDimension: .fractionalHeight(0.28)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                
                section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
                section.contentInsets.leading = 16
                section.boundarySupplementaryItems = [
                    .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: Constants.headerID, alignment: .topLeading)]
                return section
            } else {
                //News
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.95), heightDimension: .fractionalHeight(0.65)))
                item.contentInsets.bottom = 10
                
                let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(180)), subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets.leading = 16
                section.boundarySupplementaryItems = [
                    .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: Constants.headerID, alignment: .topLeading)
                ]
                return section
            }
        }
    }
}


extension DashboardViewController: DashboardInputDelegate {
    func stockTickerFetched() {
        self.collectionView.performBatchUpdates {
            self.collectionView.reloadSections(IndexSet.init(integer: 0))
        }
    }
    
    func horizontalNewsHeadlinesFetched() {
        self.collectionView.performBatchUpdates {
            self.collectionView.reloadSections(IndexSet.init(integer: 1))
        }
    }
    
    func verticleNewsListFetched() {
        self.collectionView.performBatchUpdates {
            self.collectionView.reloadSections(IndexSet.init(integer: 2))
        }
    }
}
