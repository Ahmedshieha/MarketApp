//
//  HomeViewController.swift
//  MarketApp
//
//  Created by MacBook on 11/03/2022.
//

import UIKit

class HomeViewController: UIViewController  , UICollectionViewDataSource , UICollectionViewDelegate {
    
    var categoryArray : [Category] =  []
    
    let images  = [UIImage(named: "offer"),UIImage(named: "offer2")]
    let imageNames = ["offer","offer2"]
    let categoryHeaderId = "categoryHeaderId"
    let headerId = "headerId"
    
    @IBOutlet weak var homeCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadCategories()
        self.navigationItem.title = "Home"
        configureCollectionViewAndCells()
        
    }
    
    
    
    func downloadCategories() {
        downloadCategoriesFromFirebase { categories in
            self.categoryArray = categories
            self.homeCollectionView.reloadData()
        }
    }
    
    
    func configureCollectionViewAndCells() {
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
        homeCollectionView.collectionViewLayout = createCompostionalLayout()
        homeCollectionView.register(Header.self, forSupplementaryViewOfKind: categoryHeaderId, withReuseIdentifier: headerId)
        self.homeCollectionView.register(UINib(nibName: "HomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell2")
        self.homeCollectionView.register(UINib(nibName: "offerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell3")
    }
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 1 {
            return categoryArray.count
        }
        return  2
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if indexPath.section ==  1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath)  as! HomeCollectionViewCell
            cell.configureCell(category: categoryArray[indexPath.row])
            cell.layer.cornerRadius = 15
            cell.backgroundColor = .orange
            return cell
        }
        
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell3", for: indexPath)  as! offerCollectionViewCell
        
        cell.offerimage.image  = images[indexPath.row]
        
        cell.offerimage.layer.cornerRadius = 15
        return cell
        
        
        
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header1 = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath)
        header1.backgroundColor = .white
        return header1
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.section == 1 {
            performSegue(withIdentifier: "categoryToItemsSeg", sender: categoryArray[indexPath.row])
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "categoryToItemsSeg" {
            let vc = segue.destination as! ItemsTableViewController
            vc.category = (sender as! Category)
            
        }
    }
    
    func createCompostionalLayout () -> UICollectionViewCompositionalLayout {
        
        return UICollectionViewCompositionalLayout {( sectionNumber , env ) -> NSCollectionLayoutSection? in
            
            if sectionNumber == 0 {
                return self.offerLayoutSection()
            }  else if sectionNumber == 1 {
                return  self.categoryLayoutSection()
            }
            
            return self.offerLayoutSection()
        }
        
    }
    
    func offerLayoutSection () -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        item.contentInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 5)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalHeight(0.2))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = .init(top: 10 , leading: 10, bottom: 10, trailing: 10)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior  = .groupPaging
        
        return section
        
    }
    
    func categoryLayoutSection () -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.33))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        item.contentInsets = .init(top: 2, leading: 2, bottom: 2, trailing: 2)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33), heightDimension: .fractionalHeight(0.5))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = .init(top: 10 , leading: 5, bottom: 10, trailing: 2)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior  = .continuous
        section.boundarySupplementaryItems = [NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(0.9), heightDimension: .estimated(30)),elementKind: categoryHeaderId , alignment: .top)]
        
        return section
        
    }
    
    
    
    
}
class Header : UICollectionReusableView {
    let lable = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        lable.text = "Category"
        //        lable.font = UIFont(name: "Apple SD Gothic Neo", size: 18)
        lable.font  = UIFont.boldSystemFont(ofSize: 18)
        addSubview(lable)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        lable.frame = bounds
    }
    
}
