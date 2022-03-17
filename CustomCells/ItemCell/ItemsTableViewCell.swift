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
    @IBOutlet weak var itemPriceLable: UILabel?
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
        
        if item.price != nil {
            itemPriceLable?.text = "$" + convertToCurrency(item.price)
        } else {
            itemPriceLable?.text =  "$" + "0.0"
        }
        
        itemPriceLable?.adjustsFontSizeToFitWidth = true
        
    }

}
