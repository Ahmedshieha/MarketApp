//
//  BasketViewController.swift
//  MarketApp
//
//  Created by MacBook on 16/03/2022.
//

import UIKit
import JGProgressHUD
import SwipeCellKit

class BasketViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource, SwipeCollectionViewCellDelegate {
    
    
    var basket : Basket?
    var itemsArray:[Item] = []
    var hud = JGProgressHUD()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ItemsBasketCollectionView.register(UINib(nibName: "ItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "itemCell")
        ItemsBasketCollectionView.collectionViewLayout = createCompostionalLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        loadBasket()
        ItemsBasketCollectionView.backgroundColor = .white
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadBasket()
    }
    
    fileprivate func loadItems() {
        if basket != nil {
            downloadItemsFromFirebase(withItemIds: basket!.itemdIds) { itemsArray in
                self.itemsArray = itemsArray
                self.updateTotalLables()
                self.ItemsBasketCollectionView.reloadData()
            }
        }
    }
    
   private func loadBasket() {
        downloadBasketFromFirebase(ownerId: "1234") { basket in
            self.basket = basket
            self.loadItems()
        }
    }
    
    @IBOutlet weak var totalInBasketLable: UILabel!
    
    private func updateTotalLables () {
        calcuteBasketPrice()
        self.countLable.text = String(itemsArray.count)
    }
    
   private func calcuteBasketPrice () {
        
        var newArray : [Double] = []
        for item in itemsArray {
            if itemsArray.count > 0 {
                let itemPrice = item.price!
                newArray.append(itemPrice)
            }
        }
        let sum = newArray.reduce(0, +)
        self.totalInBasketLable.text = " $ \(sum)"
    }
    
    @IBOutlet weak var itemsCountLable: UILabel!
    @IBOutlet weak var countLable: UILabel!
    @IBAction func checkOutButton(_ sender: Any) {
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsArray.count
    }
 
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemCell", for: indexPath) as! ItemCollectionViewCell
        cell.configureItemCellTest(item: itemsArray[indexPath.row])
        cell.backgroundColor = .white
        cell.delegate = self
        cell.backgroundColor = .lightGray
        cell.itemImage.layer.cornerRadius = 10
        cell.layer.cornerRadius = 10
        return  cell
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, editActionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right  else  {return nil}
        let deletAction = SwipeAction(style: .destructive, title: nil) { action, indexPath in
            let itemToDelete = self.itemsArray[indexPath.row]
            self.itemsArray.remove(at: indexPath.row)
            self.removeItemFromBasket(itemId: itemToDelete.id)
            updateBasketInFireBase(self.basket!, withValues: ["itemIds" : self.basket!.itemdIds!]) { error in
                if error != nil {
                    print(error!.localizedDescription)
                }
                self.updateTotalLables()
            }
        }
        
        deletAction.image  = UIImage(named: "delete")
        configure(action: deletAction, with: .trash)
        return [deletAction]
    }
    
   private func  removeItemFromBasket(itemId : String) {
        for  i  in 0..<basket!.itemdIds.count{
            if itemId == basket?.itemdIds[i] {
                basket!.itemdIds.remove(at: i)
                return
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, editActionsOptionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var option = SwipeOptions()
        option.expansionStyle =  orientation == .left ? .selection  :.destructive
        option.backgroundColor  =  .white
        
        return option
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil)
        let itemDetailsViewController = vc.instantiateViewController(withIdentifier: "ItemDetailsViewController")  as? ItemDetailsViewController
        itemDetailsViewController?.item = itemsArray[indexPath.row]
        self.navigationController?.pushViewController(itemDetailsViewController!, animated: true)
    }
    
    @IBOutlet weak var ItemsBasketCollectionView: UICollectionView!
    
    
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

//Mark : swipe Action
var defaultOptions = SwipeOptions()
var isSwipeRightEnabled = true
var buttonDisplayMode: ButtonDisplayMode = .titleAndImage
var buttonStyle: ButtonStyle = .backgroundColor
var usesTallCells = false

func configure(action: SwipeAction, with descriptor: ActionDescriptor) {
    action.title = descriptor.title(forDisplayMode: buttonDisplayMode)
    action.image = descriptor.image(forStyle: buttonStyle, displayMode: buttonDisplayMode)
    
    switch buttonStyle {
    case .backgroundColor:
        action.backgroundColor = descriptor.color(forStyle: buttonStyle)
    case .circular:
        action.backgroundColor = .clear
        action.textColor = descriptor.color(forStyle: buttonStyle)
        action.font = .systemFont(ofSize: 13)
        action.transitionDelegate = ScaleTransition.default
    }
}
