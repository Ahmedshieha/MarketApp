//
//  GetItems.swift
//  MarketApp
//
//  Created by MacBook on 28/02/2022.
//

import Foundation
import UIKit

func downloadItemsFromFirebase(withCategoryId  : String , completionHandler : @escaping(_ itemArray :[Item])->Void ){
    
    var itemArray : [Item] = []
    
    FirebaseCollectionRefrence(.Item).whereField("categoryId", isEqualTo: withCategoryId)
        .getDocuments { (snapShot, error) in
        guard let snapShot = snapShot else {
            print(error?.localizedDescription ?? "")
            completionHandler(itemArray)
            return
        }
        if !snapShot.isEmpty {
            for itemDictinory in snapShot.documents {
                itemArray.append(Item(_dictionary: itemDictinory.data()as NSDictionary))
            }
        }
        completionHandler(itemArray)
    }
    
}
