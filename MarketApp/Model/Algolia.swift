//
//  Algolia.swift
//  MarketApp
//
//  Created by MacBook on 05/04/2022.
//

import Foundation
import InstantSearchClient


class  AlgoliaService  {
       
    static let shared = AlgoliaService()
    
    private init () {}
    
    let client = Client(appID: KALGOLIA_APP_ID, apiKey: KALGOLIA_ADMIN_KEY)
    let index = Client(appID: KALGOLIA_APP_ID, apiKey: KALGOLIA_ADMIN_KEY).index(withName: "item_Name")
    
}
