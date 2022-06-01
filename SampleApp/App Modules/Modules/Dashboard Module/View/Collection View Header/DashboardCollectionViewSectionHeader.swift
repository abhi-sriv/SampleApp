//
//  DashboardCollectionViewSectionHeader.swift
//  SampleApp
//
//  Created by Abhishek Srivastava on 29/05/22.
//

import Foundation
import UIKit

class DashboardCollectionViewSectionHeader: UICollectionReusableView {
    let sectionTitleLabel = UILabel()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.sectionTitleLabel)
        self.sectionTitleLabel.font = .boldSystemFont(ofSize: 14)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.sectionTitleLabel.frame = bounds
    }
}
