//
//  PurchaseItemsViewController.swift
//  MarketApp
//
//  Created by MacBook on 29/03/2022.
//

import UIKit

class PurchaseItemsViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
 

    
    var items : [Item] = []
    
    @IBOutlet weak var purchaseItemsCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.purchaseItemsCollectionView.register(UINib(nibName: "ItemCollectionViewCell", bundle: nibBundle), forCellWithReuseIdentifier: "itemCell")
        self.purchaseItemsCollectionView.collectionViewLayout = createCompostionalLayout()
        loadItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemCell", for: indexPath) as! ItemCollectionViewCell
        cell.configureItemCellTest(item: items[indexPath.row])
        cell.backgroundColor = .lightGray
        cell.itemImage.layer.cornerRadius = 10
        cell.layer.cornerRadius = 10
        return  cell
        
    }
    
    func loadItems () {
        if MUSer.currentUser() != nil {
            downloadItemsFromFirebase(withItemIds: MUSer.currentUser()!.purchasedItems) { allItems in
                self.items = allItems
                self.purchaseItemsCollectionView.reloadData()
            }
        } else {
            print("no user ")
        }
       
    }
    private func createCompostionalLayout () -> UICollectionViewCompositionalLayout {
        
        return UICollectionViewCompositionalLayout {( sectionNumber , env ) -> NSCollectionLayoutSection? in
            
            if sectionNumber ==  0 {
                return self.itemsLayoutSection()
            }
            return self.itemsLayoutSection()
        }
     
    }
    private func itemsLayoutSection () -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
         let item = NSCollectionLayoutItem(layoutSize: itemSize)
         
         item.contentInsets = .init(top: 2, leading: 2, bottom: 2, trailing: 2)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.15))
         
         let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
         group.contentInsets = .init(top: 5 , leading: 5, bottom: 5, trailing: 5)
         
         let section = NSCollectionLayoutSection(group: group)
         section.orthogonalScrollingBehavior  = .none
         
         return section
         
     }

}
