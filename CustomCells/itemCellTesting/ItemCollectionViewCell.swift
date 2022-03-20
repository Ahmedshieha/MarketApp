//
//  ItemCollectionViewCell.swift
//  MarketApp
//
//  Created by MacBook on 16/03/2022.
//

import UIKit
import SwipeCellKit

class ItemCollectionViewCell: SwipeCollectionViewCell {

    @IBOutlet weak var itemLableName: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
 
    @IBOutlet weak var itemPriceLable: UILabel!
    @IBOutlet weak var itemDescriptionLable: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func configureItemCellTest(item:Item) {
        
        itemLableName.text = item.name
        itemPriceLable.text? = "$" + convertToCurrency(item.price)
        itemDescriptionLable.text  = item.description
        itemPriceLable.adjustsFontSizeToFitWidth =  true
    }

}
