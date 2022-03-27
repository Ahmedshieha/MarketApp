//
//  ProfileViewController.swift
//  MarketApp
//
//  Created by MacBook on 27/03/2022.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var logInAndLogOut: UIButton!
    @IBOutlet weak var purchaseHistory: UIButton!
    @IBOutlet weak var finishRegistration: UIButton!
    @IBOutlet weak var termsAndConditions: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        logInAndLogOut.layer.borderWidth = 0.2
        purchaseHistory.layer.borderWidth = 0.2
        finishRegistration.layer.borderWidth = 0.2
        termsAndConditions.layer.borderWidth = 0.2
        checkLoginState()
        checkOnBoardState()
        
    }
    
    @IBAction func logInAndlogOutButtonAction(_ sender: Any) {
    }
    
    @IBAction func purchaseHistoryButtonAction(_ sender: Any) {
    }
    
    
    @IBAction func termsAndConditionsAction(_ sender: Any) {
    }
    
    @IBAction func finishRegistrationAction(_ sender: Any) {
    }
    
    func checkLoginState() {
        if MUSer.currentUser() == nil {
            self.logInAndLogOut.setTitle("Login", for: .normal)
        }
        else {
            self.logInAndLogOut.setTitle("Logout", for: .normal)
        }
    }
    
    func checkOnBoardState() {
        if MUSer.currentUser() != nil {
            
            if MUSer.currentUser()!.onBoard {
                finishRegistration.isEnabled = false
            } else {
                finishRegistration.isEnabled = true
            }
            
        }
        
        
    }
}


