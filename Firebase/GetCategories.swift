//
//  GetData.swift
//  MarketApp
//
//  Created by MacBook on 24/02/2022.
//

import Foundation
import UIKit

func downloadCategoriesFromFirebase(completionHandler :@escaping ([Category])->Void){
    
    var categoryArray : [Category] = []
    
    FirebaseCollectionRefrence(.Category).getDocuments {(snapShot , error) in
        guard let snapShot = snapShot else {
//            completionHandler(categoryArray)
            print(error!.localizedDescription)
            return

        }

        if !snapShot.isEmpty {
            for  categoryDictinory in snapShot.documents {
                categoryArray.append(Category(_dictionary: categoryDictinory.data()as NSDictionary))
            }
           
        }
        completionHandler(categoryArray)
        
    }
    
}
