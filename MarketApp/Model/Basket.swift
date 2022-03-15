//
//  Basket.swift
//  MarketApp
//
//  Created by MacBook on 15/03/2022.
//

import Foundation


class Basket {
    var id : String!
    var ownerId : String!
    var itemdIds :  [String]!
    
    
    
    init () {
        
    }
    
    init(_dictionary: NSDictionary) {
        
        id = _dictionary["basketId"] as?  String
        ownerId  = _dictionary["ownerId"]as? String
        itemdIds = _dictionary["itemIds"] as? [String]
    }
    
    
}
