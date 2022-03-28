//
//  OnBoardViewController.swift
//  MarketApp
//
//  Created by MacBook on 28/03/2022.
//

import UIKit
import JGProgressHUD
    
class OnBoardViewController: UIViewController {
       let hud = JGProgressHUD()
    var checkNumberOnBoard : Int = 0
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var doneButtonLayout: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        doneButtonLayout.layer.cornerRadius = 5
        
        firstNameTextField.addTarget(self, action: #selector(self.didTextFieldChange), for: UIControl.Event.editingChanged)
        lastNameTextField.addTarget(self, action: #selector(self.didTextFieldChange), for: UIControl.Event.editingChanged)
        addressTextField.addTarget(self, action: #selector(self.didTextFieldChange), for: UIControl.Event.editingChanged)
        if checkNumberOnBoard == 1 {
            print("finishRegistration")
        } else {
            print("Edit")
        }
        
    }
    @IBAction func cancleButton(_ sender: Any) {
        firstNameTextField.text = ""
        lastNameTextField.text = ""
        addressTextField.text = "" 
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneButton(_ sender: Any) {
        finishUpdatingProfile()
    }
    
    @objc func didTextFieldChange(_ textField : UITextField) {
        print("changed")
        updateDoneButton()
    }
    
    private func updateDoneButton () {
        
        if firstNameTextField.text != "" && lastNameTextField.text != "" && addressTextField.text != "" {
            
            doneButtonLayout.backgroundColor = .systemPink
            doneButtonLayout.tintColor =  .white
            doneButtonLayout.isEnabled = true
            
        }
        else {
            doneButtonLayout.backgroundColor = .gray
            doneButtonLayout.isEnabled = false
        }
        
    }
    func hideLoading() {
        self.hud.dismiss()
    }
    func showLoading() {
        self.hud.textLabel.text = "Loading"
        self.hud.show(in: self.view)
    }
    
    func finishUpdatingProfile() {
         
        let values = ["firstName" : firstNameTextField.text! , "lastName" : lastNameTextField.text!,"onBoard" : true , "fullAddress" : addressTextField.text! , "fullName" : (firstNameTextField.text! + "" + lastNameTextField.text!)] as [String:Any]
        
        updateCurrentUserInFireBase(withValues: values) { error in
            if error == nil {
                self.hud.textLabel.text = "Updated!"
                self.hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                self.hud.show(in: self.view)
                self.hud.dismiss(afterDelay: 2.0)
                self.dismiss(animated: true, completion: nil)
            }
            else {
                self.hud.textLabel.text = "\(error!.localizedDescription)!"
                self.hud.indicatorView = JGProgressHUDErrorIndicatorView()
                self.hud.show(in: self.view)
                self.hud.dismiss(afterDelay: 2.0)
            }
        }
        
    }
    
    

}
