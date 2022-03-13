//
//  Item.swift
//  MarketApp
//
//  Created by MacBook on 26/12/2021.
//

import Foundation
import UIKit

class Item {
    var id : String!
    var categoryId : String!
    var name : String!
    var description : String!
    var price : Double!
    var imageLinks : [String]!
    
    
    init() {
        
    }
    
    init(_dictionary : NSDictionary) {
        id = _dictionary ["objectId"] as? String
        categoryId = _dictionary ["categoryId"] as? String
        name = _dictionary["name"] as? String
        description = _dictionary["description"]as? String
        price = _dictionary ["price"] as? Double
        imageLinks = _dictionary["imageLinks"] as? [String]
    }
}
    
    
    

