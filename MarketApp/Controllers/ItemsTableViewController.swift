//
//  ItemsTableViewController.swift
//  MarketApp
//
//  Created by MacBook on 26/12/2021.
//

import UIKit

class ItemsTableViewController: UITableViewController {
    
    var category : Category?
    var items: [Item] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        //        tableView.dataSource  = self
        //        tableView.delegate = self
        tableView.tableFooterView = UIView()
        self.title = category?.name
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if category != nil {
            downloadItems()
        }
        
    }
    
    func downloadItems() {
        downloadItemsFromFirebase(withCategoryId: category?.id ?? "") { allItemsinCategory in
            self.items = allItemsinCategory
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("cell for row at")
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell") as! ItemsTableViewCell
        cell.configureItemCell(item: items[indexPath.row])
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addItemToItems" {
            let vc = segue.destination as! AddItemViewController
            vc.category = category!
            
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = UIStoryboard(name: "Main", bundle: nil)
        let itemDetailsViewController = vc.instantiateViewController(withIdentifier: "ItemDetailsViewController")  as? ItemDetailsViewController
        itemDetailsViewController?.item = items[indexPath.row]
        self.present(itemDetailsViewController!, animated: true, completion: nil)
        
        
    }
    
    
}
