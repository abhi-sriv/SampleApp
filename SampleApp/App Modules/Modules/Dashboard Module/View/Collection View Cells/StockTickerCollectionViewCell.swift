//
//  StockTickerCollectionViewCell.swift
//  SampleApp
//
//  Created by Abhishek Srivastava on 29/05/22.
//

import UIKit

class StockTickerCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var stockNameLabel: UILabel!
    @IBOutlet weak var stockPriceLabel: UILabel!
    
    func configureCell(tickerObj: StockTickerModel) {
        self.stockNameLabel.text = tickerObj.stockName
        self.stockPriceLabel.text = String(format: "$%.2f", tickerObj.stockPrice)
    }
}
