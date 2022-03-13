//
//  FirebaseRefrence.swift
//  MarketApp
//
//  Created by MacBook on 22/12/2021.
//

import Foundation
import FirebaseFirestore
import AVFAudio

enum FcollectionFirebase:String {
    case User
    case Category
    case Item
    case Basket

}

func FirebaseCollectionRefrence (_ collectionRefrence : FcollectionFirebase) -> CollectionReference {
    return Firestore.firestore().collection(collectionRefrence.rawValue)
}
    





    

