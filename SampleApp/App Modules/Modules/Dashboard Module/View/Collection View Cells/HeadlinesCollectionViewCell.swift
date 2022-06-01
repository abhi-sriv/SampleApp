//
//  HeadlinesCollectionViewCell.swift
//  SampleApp
//
//  Created by Abhishek Srivastava on 29/05/22.
//

import UIKit
import Kingfisher

class HeadlinesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var newsTitleLabel: UILabel!
    
    func configureCell(articleObj: Articles) {
        self.newsTitleLabel.text = articleObj.title ?? ""
        let url = URL(string: articleObj.urlToImage ?? "")
        self.newsImageView.kf.setImage(with: url)
    }
}
