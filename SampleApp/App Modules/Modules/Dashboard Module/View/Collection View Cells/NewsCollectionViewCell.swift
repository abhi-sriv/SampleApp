//
//  NewsCollectionViewCell.swift
//  SampleApp
//
//  Created by Abhishek Srivastava on 29/05/22.
//

import UIKit
import Kingfisher

class NewsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsDateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func configureCell(articleObj: Articles) {
        let imageUrl = URL.init(string: articleObj.urlToImage ?? "")
        self.newsImageView.kf.setImage(with: imageUrl)
        self.newsTitleLabel.text = articleObj.title ?? ""
        self.newsDateLabel.text = self.getFormattedDate(dateStr: articleObj.publishedAt ?? "")
        self.descriptionLabel.text = articleObj.description
    }
    
    func getFormattedDate(dateStr: String) -> String {
        let dateFormatter = ISO8601DateFormatter()
        let date = dateFormatter.date(from: dateStr)
        let strFromDate = date?.description ?? ""
        return strFromDate
    }
}
