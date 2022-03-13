//
//  ItemDetailsViewController.swift
//  MarketApp
//
//  Created by MacBook on 13/03/2022.
//

import UIKit

class ItemDetailsViewController: UIViewController {
    
    var  item :  Item?

    @IBOutlet weak var itemImagesCollectionView: UICollectionView!
    
    @IBOutlet weak var itemNameLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

}
