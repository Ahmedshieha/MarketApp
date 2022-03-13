//
//  UploadItems.swift
//  MarketApp
//
//  Created by MacBook on 24/02/2022.
//

import Foundation
import UIKit 

func convertToDictionary (_ item : Item) -> NSDictionary {
    return NSDictionary(objects: [item.id , item.categoryId , item.name,item.description , item.price,item.imageLinks], forKeys: ["objectId" as NSCopying , "categoryId" as NSCopying , "name" as NSCopying , "description" as NSCopying , "price" as NSCopying , "imageLinks" as NSCopying ])
}

func saveItemToFirebase ( item : Item)  {
  
    FirebaseCollectionRefrence(.Item).document(item.id).setData(convertToDictionary(item) as! [String:Any])
}

func createItems () {
    
}
