//
//  StripeClient.swift
//  MarketApp
//
//  Created by MacBook on 08/04/2022.
//

import Foundation
import Stripe
import Alamofire

class StripeClient {
    static let sharedClient = StripeClient()
    
    var baseUrlString :String? = nil
    
    var baseURL : URL {
        if let urlString = self.baseUrlString , let url = URL(string: urlString) {
            return url
        } else {
            fatalError()
        }
        
    }
    func createAndConfirmPayment(_ token : STPToken , amount : Int , completionHandler:@escaping (_ error : Error?) -> Void) {
        let url = self.baseURL.appendingPathComponent("charge")
        let parms : [String:Any] = ["stripeToken" : token.tokenId , "amount" : amount , "description" : constats.defaultDescription , "currency" : constats.defaultCurrency]
        AF.request(url,method: .post , parameters: parms).validate(statusCode: 200..<300).responseData { response in
            switch response.result {
            case .success(_ ) :
                print("success")
                completionHandler(nil)
            case.failure(let error) :
                print(error.localizedDescription)
                completionHandler(error)
            }
        }
    }
   
}
