//
//  Items.swift
//  MarketApp
//
//  Created by MacBook on 05/04/2022.
//

import Foundation

import InstantSearchClient
func saveItemToAlgolia(item: Item) {
    let index = AlgoliaService.shared.index
    let itemToSave = convertToDictionary(item) as! [String:Any]
    index.saveObject(itemToSave, requestOptions: nil) { content, error in
        if error != nil {
            print("can't add to algolia \(error!.localizedDescription)")
            
        } else {
            print("added to algolia")
        }
    }
//    index.addObject(itemToSave, withID: item.id, requestOptions: nil) { content, error in
//
//    }
}
