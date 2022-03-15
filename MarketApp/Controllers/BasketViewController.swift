//
//  BasketViewController.swift
//  MarketApp
//
//  Created by MacBook on 16/03/2022.
//

import UIKit

class BasketViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.ItemsBasketCollectionView.register(UINib(nibName: "ItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "testCell")
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var itemsCountLable: UILabel!
    
    @IBAction func checkOutButton(_ sender: Any) {
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "testCell", for: indexPath) as! ItemCollectionViewCell
       
        cell.backgroundColor = .blue
        return  cell
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    @IBOutlet weak var ItemsBasketCollectionView: UICollectionView!
    
   
    
    
    

    

}
