//
//  ItemDetailsViewController.swift
//  MarketApp
//
//  Created by MacBook on 13/03/2022.
//

import UIKit

class ItemDetailsViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource  {
    
    
    var itemImages : [UIImage] = []
    
    var  item :  Item!
    
    @IBOutlet weak var itemImagesCollectionView: UICollectionView!
    
    @IBOutlet weak var itemNameLable: UILabel!
    
    @IBOutlet weak var itemPriceLable: UILabel!
    @IBOutlet weak var itemDescriptionLable: UILabel!
    @IBOutlet weak var itemDescriptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemImagesCollectionView.collectionViewLayout = createCompostionalLayout()
        itemNameLable.text = item?.name
        itemPriceLable.text? = "Price :" + "  " + "$" + convertToCurrency(item.price)
        itemPriceLable.textColor = .red
        itemDescriptionTextView.text = item.description ?? ""
        downloadItemImages()
        print(item.imageLinks.count)
        itemImagesCollectionView.dataSource = self
        itemImagesCollectionView.delegate =  self
        itemImagesCollectionView.register(UINib(nibName: "ItemImagesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Itemimagecell")
    }
    
    
    func downloadItemImages () {
        downloadImages(imageLinks: item.imageLinks) { images in
            if images.count > 0 {
                
                DispatchQueue.main.async {
                    self.itemImages = images as! [UIImage]
                    self.itemImagesCollectionView.reloadData()
                }
                
            }
            else {
                self.itemImages = []
            }
        }
    }
    
    
    
    
    func imagesLayoutSection () -> NSCollectionLayoutSection {
        
        let itemSize  = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 5)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalHeight(1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = .init(top: 10 , leading: 10, bottom: 10, trailing: 10)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "Itemimagecell", for: indexPath)  as! ItemImagesCollectionViewCell
        //        cell.itemImageView.image = itemImages[indexPath.row]
        cell.configureImageCell(image: itemImages[indexPath.row])
        cell.layer.cornerRadius = 10
        cell.itemImageView.layer.cornerRadius = 10
        return cell
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func createCompostionalLayout () -> UICollectionViewCompositionalLayout {
        
        return UICollectionViewCompositionalLayout {( sectionNumber , env ) -> NSCollectionLayoutSection? in
            if sectionNumber == 1 {
                return self.imagesLayoutSection()
            }
            return self.imagesLayoutSection()
        }
        
    }
    
}




