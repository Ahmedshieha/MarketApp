//
//  HomeCollectionViewCell.swift
//  MarketApp
//
//  Created by MacBook on 11/03/2022.
//

import UIKit
import Foundation
class HomeCollectionViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        categoryImage.image = UIImage(named: "baby")
//        categoryLable.text = "baby"
        categoryLable2.textColor =  .white
    }
    @IBOutlet weak var categoryImage2: UIImageView!
    
    
    @IBOutlet weak var categoryLable2: UILabel!
    

    
    func configureCell (category : Category) {
        categoryLable2.text! = category.name ?? ""
        categoryImage2.image = category.image
    }
}
