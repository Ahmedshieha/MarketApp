//
//  User.swift
//  MarketApp
//
//  Created by MacBook on 21/03/2022.
//

import Foundation
import FirebaseAuth

class MUSer  {
    
    let objectId : String
    var email : String
    var firstName  : String
    var lastName : String
    var fullName : String
    var purchasedItems : [String]
    
    var fullAddress : String
    var onBoard : Bool
    
    
    init (_objectId : String, _email:String , _firstName : String , _lastName:String) {
        
        
        objectId = _objectId
        email = _email
        firstName =  _firstName
        lastName = _lastName
        fullName = _firstName + " " + _lastName
        fullAddress = ""
        purchasedItems = []
        onBoard = false
        
    }
    
    init(_dictionary : NSDictionary)  {
        objectId  = _dictionary["objectId"] as! String
        
        if let mail = _dictionary ["email"] {
            email = mail as! String
        }
        else {
            email = ""
        }
        
        if let fName = _dictionary ["firstName"] {
            firstName = fName as! String
        }
        else {
            firstName = ""
        }
        
        if let lName = _dictionary ["lastName"] {
            lastName = lName as! String
        }
        else {
            lastName = ""
        }
        fullName  = firstName + " " + lastName
        
        if let fAddress = _dictionary ["fullAddress"] {
            fullAddress = fAddress as! String
        }
        else {
            fullAddress = ""
        }
        if let onB = _dictionary ["onBoard"] {
            onBoard = onB as! Bool
        }
        else {
            onBoard = false
        }
        
        if let purch = _dictionary ["purchasedItems"] {
            purchasedItems = purch as! [String]
        }
        else {
            purchasedItems = []
        }
    }
    
    class func currentUserId() -> String {
        return Auth.auth().currentUser!.uid
        
    }
    
    class func currentUser () -> MUSer?  {
        
        if Auth.auth().currentUser != nil {
            if  let dictionary = UserDefaults.standard.object(forKey: "currentUser"){
                return MUSer.init(_dictionary: dictionary as! NSDictionary)
            }
        }
        return  nil
    }
    
   class func loginUserWith (email : String , password:String , completion : @escaping (_ error : Error? , _ isEmailVerified : Bool)-> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authDataResult, error in
            if error == nil {
                if authDataResult!.user.isEmailVerified {
                    completion(error , true)
                } else {
                    print("email is not verified")
                    completion(error,false)
                }
            } else {
                completion(error,false)
            }
        }
    }
    
    class func registerUserWith(email:String, password:String, completion:@escaping(_ error:Error?)->Void){
        Auth.auth().createUser(withEmail: email, password: password) { authDataResult, error in
            completion(error)
            if error == nil {
                
//                sendEmailVerification
                authDataResult?.user.sendEmailVerification(completion: { error in
                    print("auth email verification error \(error?.localizedDescription)")
                })
            }
        }
    }
}
