//
//  SaveToBasket.swift
//  MarketApp
//
//  Created by MacBook on 15/03/2022.
//

import Foundation




func convertBasketToDictionary (basket :Basket) -> NSDictionary {
    return NSDictionary(objects: [basket.id , basket.itemdIds , basket.ownerId], forKeys: ["basketId" as NSCopying , "itemIds" as NSCopying , "ownerId" as NSCopying])
}

func saveToBasket(basket: Basket , completionHandler :@escaping (_ error:Error?) ->  Void)  {
    
    FirebaseCollectionRefrence(.Basket).document(basket.id).setData(convertBasketToDictionary(basket: basket)as![String:Any])
}

func downloadBasketFromFirebase(ownerId : String ,  completionHandler : @escaping (_ basket  : Basket?) -> Void) {
//    var basketArray : [Basket] = []
    
    FirebaseCollectionRefrence(.Basket).whereField("ownerId", isEqualTo: ownerId).getDocuments { snapShot, error in
        
        guard let snapShot = snapShot else {
            completionHandler(nil)
            return
        }
        
        if !snapShot.isEmpty  && snapShot.documents.count > 0  {
            
            let basket  = Basket(_dictionary: snapShot.documents.first!.data() as NSDictionary)
            completionHandler(basket)
        }
        else {
            completionHandler(nil)
        }
        
    }
}
func updateBasketInFireBase (_ basket: Basket , withValues  : [String : Any],  completion :@escaping(_ error: Error?) -> Void) {
    
    FirebaseCollectionRefrence(.Basket).document(basket.id).updateData(withValues) { error in
        completion(error)
    }
}

