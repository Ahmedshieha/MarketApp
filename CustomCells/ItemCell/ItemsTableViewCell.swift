//
//  ItemsTableViewCell.swift
//  MarketApp
//
//  Created by MacBook on 28/02/2022.
//

import UIKit

class ItemsTableViewCell: UITableViewCell {

    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemNameLable: UILabel!
    @IBOutlet weak var itemPriceLable: UILabel!
    @IBOutlet weak var itemDescriptionLable: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureItemCell (item : Item) {
        itemNameLable.text = item.name
        itemDescriptionLable.text = item.description
        itemPriceLable.text? = "$" + convertToCurrency(item.price) 
        itemPriceLable.adjustsFontSizeToFitWidth = true
        if item.imageLinks != nil {
            downloadImages(imageLinks: [item.imageLinks.first!]) { images in
                self.itemImage.image = images.first
            }
        }
        
        
    }

}
