//
//  BasketViewController.swift
//  MarketApp
//
//  Created by MacBook on 16/03/2022.
//

import UIKit
import JGProgressHUD

class BasketViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    var basket : Basket?
    var itemsArray:[Item] = []
    var hud = JGProgressHUD()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.ItemsBasketCollectionView.register(UINib(nibName: "ItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "testCell")
       
        // Do any additional setup after loading the view.
       
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadBasket()
        
    }
    
    func loadBasket() {
        downloadBasketFromFirebase(ownerId: "1234") { basket in
            self.basket = basket
            
            if basket != nil {
                downloadItemsFromFirebase(withItemIds: basket!.itemdIds) { itemsArray in
                    self.itemsArray = itemsArray
                    self.countLable.text = String (itemsArray.count)
                    self.calcuteBasketPrice()
                    self.ItemsBasketCollectionView.reloadData()
                }
            }
           
        }
    }
    @IBOutlet weak var totalInBasketLable: UILabel!
    
    func calcuteBasketPrice () {
        
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
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "testCell", for: indexPath) as! ItemCollectionViewCell
        cell.configureItemCellTest(item: itemsArray[indexPath.row])
        cell.backgroundColor = .gray
        return  cell
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    @IBOutlet weak var ItemsBasketCollectionView: UICollectionView!
    
   
    
    
    

    

}
