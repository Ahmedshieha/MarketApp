//
//  ProfileViewController.swift
//  MarketApp
//
//  Created by MacBook on 27/03/2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var checkEditOrFinishRegistrationNumber : Int = 0

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
      
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkLoginState()
        checkOnBoardState()
    }

    @objc func editPofile() {
        let checkButton : Int = 1
        self.checkEditOrFinishRegistrationNumber = checkButton
        showOnBoardView()
       
        
    }
    
    @IBAction func logInAndlogOutButtonAction(_ sender: Any) {
        if logInAndLogOut.titleLabel?.text == "Logout" {
            
        } else {
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            self.navigationController?.pushViewController(vc, animated: true)
            checkOnBoardState()
        }
    }
    
    @IBAction func purchaseHistoryButtonAction(_ sender: Any) {
    }
    
    
    @IBAction func termsAndConditionsAction(_ sender: Any) {
    }
    
    @IBAction func finishRegistrationAction(_ sender: Any) {
        let checkButton : Int = 2
        self.checkEditOrFinishRegistrationNumber = checkButton
        showOnBoardView()
    }
    
    private  func checkLoginState() {
        if MUSer.currentUser() == nil {
            self.logInAndLogOut.setTitle("Login", for: .normal)
            self.navigationItem.rightBarButtonItem = nil
        }
        else {
            self.logInAndLogOut.setTitle("Logout", for: .normal)
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editPofile))
        }
    }
    
    
    
    @objc func showOnBoardView() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "OnBoardViewController") as! OnBoardViewController
        vc.checkNumberOnBoard = self.checkEditOrFinishRegistrationNumber
        self.navigationController?.pushViewController(vc, animated: true)
        
    }

    
    
    
    
    private func checkOnBoardState() {
        if MUSer.currentUser() != nil {
            
            if MUSer.currentUser()!.onBoard{
                finishRegistration.isEnabled = false
            } else {
                finishRegistration.isEnabled = true
            }
            
        } else {
            finishRegistration.isEnabled = false
        }
        
        
    }
}


