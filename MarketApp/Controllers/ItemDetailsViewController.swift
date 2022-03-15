//
//  ItemDetailsViewController.swift
//  MarketApp
//
//  Created by MacBook on 13/03/2022.
//

import UIKit
import JGProgressHUD

class ItemDetailsViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource  {
    
    
    var itemImages : [UIImage] = []
    
    var  item :  Item!
    var basket : Basket?
    let hud = JGProgressHUD()
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
        itemImagesCollectionView.dataSource = self
        itemImagesCollectionView.delegate =  self
        itemImagesCollectionView.register(UINib(nibName: "ItemImagesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Itemimagecell")
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(self.backButton))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "basket"), style: .plain, target: self, action: #selector(self.basketButton))
    }
    
    
    
    
    func downloadItemImages () {
        
        if item != nil && item.imageLinks != nil {
            downloadImages(imageLinks: self.item.imageLinks) { images in
                DispatchQueue.main.async {
                    if images.count > 0 {
                        self.itemImages = images
                        self.itemImagesCollectionView.reloadData()
                    }
                }
            }
            
        } else {
            
        }
    }
    
    @objc func backButton () {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func basketButton () {
        addToBasketButton()
    }
    
    
    private func createNewBasket() {
        let id = UUID().uuidString
        let newBasket =  Basket()
        newBasket.id =  id
        newBasket.ownerId  = "1234"
        newBasket.itemdIds = [item.id]
        saveToBasket(basket: newBasket) { error in
            if error != nil {
                self.hud.textLabel.text =  "error\(error!.localizedDescription)"
                self.hud.indicatorView  = JGProgressHUDErrorIndicatorView()
                self.hud.show(in: self.view)
                self.hud.dismiss(afterDelay: 2.0)
            }
            else {
                self.configureSuccessIndeicator()
            }
        }
        
    }
    
    
    
    private func updateBasket(basket : Basket , withValues : [String:Any]) {
        updateBasketInFireBase(basket, withValues: withValues) { error in
            if error != nil  {
                self.hud.textLabel.text =  "error\(error!.localizedDescription)"
                self.hud.indicatorView  = JGProgressHUDErrorIndicatorView()
                self.hud.show(in: self.view)
                self.hud.dismiss(afterDelay: 2.0)
            }
            else {
                self.configureSuccessIndeicator()
                
            }
        }
    }
    
    func addToBasketButton () {
        
        downloadBasketFromFirebase(ownerId: "1234") { basket in
            if basket == nil {
                self.createNewBasket()
            } else {
                basket?.itemdIds.append(self.item.id)
                self.updateBasket(basket: basket!, withValues: ["itemIds":basket!.itemdIds!])
            }
        }
    }
    
    func configureSuccessIndeicator() {
        self.hud.textLabel.text = "Added To Basket"
        self.hud.indicatorView = JGProgressHUDSuccessIndicatorView()
        self.hud.show(in: self.view)
        //        self.hud.backgroundColor = .gray
        self.hud.dismiss(afterDelay: 2.0)
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




