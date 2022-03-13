//
//  ItemImagesCollectionViewCell.swift
//  MarketApp
//
//  Created by MacBook on 13/03/2022.
//

import UIKit

class ItemImagesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var itemImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    func configureImageCell (image  : UIImage ) {
        itemImageView.image =  image
    }
    
    
}
