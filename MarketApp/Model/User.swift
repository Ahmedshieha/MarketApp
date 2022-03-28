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
                    downloadUserFromFireBase(userId: authDataResult!.user.uid, email: email)
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
    
    class func resetPassword(email : String , completion : @escaping (_ error : Error?) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if error == nil {
                
            }
            else {
                
            }
        }
    }
    class func resendEmailVerification(email: String , completionHandler : @escaping (_ error : Error? ) -> Void) {
        Auth.auth().currentUser?.reload(completion: { error in
            Auth.auth().currentUser?.sendEmailVerification(completion: { error in
                completionHandler(error)
            })
        })
    }
    
    class func registerUserWith(email:String, password:String, completion:@escaping(_ error:Error?)->Void){
        Auth.auth().createUser(withEmail: email, password: password) { authDataResult, error in
            completion(error)
            if error == nil {
                downloadUserFromFireBase(userId: authDataResult!.user.uid, email: email)
                authDataResult?.user.sendEmailVerification(completion: { error in
                    if error == nil {
                        
                    }
                    else {
                        
                    }
                })
            } else {
                
            }
        }
    }
    class func logOut () {
        
    }
}

func convertUserToDictionary (user : MUSer) -> NSDictionary {
    return NSDictionary(objects: [user.objectId,user.email,user.firstName,user.lastName,user.fullName,user.fullAddress ?? "",user.onBoard,user.purchasedItems], forKeys: ["objectId" as NSCopying,"email" as NSCopying,"firstName" as NSCopying,"lastName" as NSCopying,"fullName" as NSCopying,"fullAddress" as NSCopying,"onBoard" as NSCopying,"purchasedItems" as NSCopying,])
    
}

func saveUserToFireBase(user : MUSer) {
    FirebaseCollectionRefrence(.User).document(user.objectId).setData(convertUserToDictionary(user: user) as! [String:Any]) { error in
        if error == nil {
            
        }
        else {
            print(error!.localizedDescription)
        }
    }
}
func saveUserLocally (userDictionary : NSDictionary) {
    UserDefaults.standard.set(userDictionary, forKey: "currentUser")
    UserDefaults.standard.synchronize()
}

func downloadUserFromFireBase(userId :String , email :String) {
    FirebaseCollectionRefrence(.User).document(userId).getDocument { snapShot, error in
        
        guard let snapShot = snapShot else {
            return
        }
        if snapShot.exists {
            print("download Current User From firestore")
            saveUserLocally(userDictionary: snapShot.data()! as NSDictionary)
        }
        else {
            let user = MUSer(_objectId: userId, _email: email, _firstName: "", _lastName: "")
            saveUserLocally(userDictionary: convertUserToDictionary(user: user ))
            saveUserToFireBase(user: user)
            
            
        }
    }
    
}
func updateCurrentUserInFireBase(withValues : [String:Any] , completion :@escaping (_ error : Error?) -> Void ) {
    
    if let currentUserDictionary = UserDefaults.standard.object(forKey: "currentUser") {
        let userObject = (currentUserDictionary as! NSDictionary ).mutableCopy() as! NSMutableDictionary
        userObject.setValuesForKeys(withValues)
        
        FirebaseCollectionRefrence(.User).document(MUSer.currentUserId()).updateData(withValues) { error in
            completion(error)
            if error == nil {
                saveUserLocally(userDictionary: userObject)
            }
            
        }
        
    }
    
}
