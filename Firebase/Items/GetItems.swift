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

func downloadItemsFromFirebase(withItemIds:[String],completion :@escaping (_ itemsArray : [Item])->Void ) {
    
    var count = 0
    var itemsArray : [Item]  = []
    
    if withItemIds.count > 0 {
        for itemId in withItemIds {
            FirebaseCollectionRefrence(.Item).document(itemId).getDocument { snapShot, error in
                guard  let snapShot = snapShot else{
                    completion(itemsArray)
                    return
                }
                if snapShot.exists {
                    itemsArray.append(Item(_dictionary: snapShot.data()!  as NSDictionary))
                    count += 1
                }
                
                else  {
                    completion(itemsArray)
                }
                if count == withItemIds.count {
                    completion(itemsArray)
                }
            }
        }
    } else {
        completion(itemsArray)
    }
}
