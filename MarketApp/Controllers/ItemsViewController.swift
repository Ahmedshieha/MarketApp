//
//  ItemsViewController.swift
//  MarketApp
//
//  Created by MacBook on 20/03/2022.
//

import UIKit

class ItemsViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
  
    @IBOutlet weak var itemsCollectionView: UICollectionView!
    
    
    var category: Category?
    var items : [Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.itemsCollectionView.register(UINib(nibName: "ItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "testCell")
        downloadItems()
        print(category?.name)
    }
    
    
    private func downloadItems () {
        
        if category != nil {
            downloadItemsFromFirebase(withCategoryId: category!.id!) { itemArray in
                self.items = itemArray
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "testCell", for: indexPath) as! ItemCollectionViewCell
        cell.configureItemCellTest(item: items[indexPath.row])
                return cell
    }
    
    
    
    
}
