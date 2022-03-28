//
//  ProfileViewController.swift
//  MarketApp
//
//  Created by MacBook on 27/03/2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var checkNumber : Int = 0

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
//        checkOnBoardState()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editPofile))
    }

    @objc func editPofile() {
        let checkButton2 : Int = 2
        self.checkNumber = checkButton2
        showOnBoardView()
       
        
    }
    
    @IBAction func logInAndlogOutButtonAction(_ sender: Any) {
        if logInAndLogOut.titleLabel?.text == "Logout" {
            
        } else {
            
        }
    }
    
    @IBAction func purchaseHistoryButtonAction(_ sender: Any) {
    }
    
    
    @IBAction func termsAndConditionsAction(_ sender: Any) {
    }
    
    @IBAction func finishRegistrationAction(_ sender: Any) {
        let checkButton2 : Int = 1
        self.checkNumber = checkButton2
        showOnBoardView()
    }
    
    private  func checkLoginState() {
        if MUSer.currentUser() == nil {
            self.logInAndLogOut.setTitle("Login", for: .normal)
        }
        else {
            self.logInAndLogOut.setTitle("Logout", for: .normal)
        }
    }
    
    
    
    @objc func showOnBoardView() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "OnBoardViewController") as! OnBoardViewController
        vc.checkNumberOnBoard = self.checkNumber
        self.present(vc, animated: true, completion: nil)
        
    }

    
    
    
    
    private func checkOnBoardState() {
        if MUSer.currentUser() != nil {
            
            if MUSer.currentUser()!.onBoard {
                finishRegistration.isEnabled = false
            } else {
                finishRegistration.isEnabled = true
            }
            
        }
        
        
    }
}


