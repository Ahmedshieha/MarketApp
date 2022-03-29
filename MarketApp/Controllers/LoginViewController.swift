//
//  LoginViewController.swift
//  MarketApp
//
//  Created by MacBook on 21/03/2022.
//

import UIKit
import JGProgressHUD
class LoginViewController: UIViewController {
    
    
    let hud = JGProgressHUD(style: .dark)
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var resendButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    @IBAction func loginButton(_ sender: Any) {
        if isTextFieldsNotEmpty() {
            login(withEmail: emailTextField.text!, withPassword: passwordTextField.text!)
            
        }else {
            self.hud.textLabel.text = "all fields are required"
            self.hud.indicatorView = JGProgressHUDErrorIndicatorView()
            self.hud.show(in: self.view)
            self.hud.dismiss(afterDelay: 2.0)
        }
        
    }
    
    @IBAction func registerButton(_ sender: Any) {
        if isTextFieldsNotEmpty() {
            registerUser(withEmail: emailTextField.text!, withPassword: passwordTextField.text!)
        }else {
            self.hud.textLabel.text = "all fields are required"
            self.hud.indicatorView = JGProgressHUDErrorIndicatorView()
            self.hud.show(in: self.view)
            self.hud.dismiss(afterDelay: 2.0)
        }
        
    }
 
    @IBAction func forgetPassword(_ sender: Any) {
        if emailTextField.text != "" {
            MUSer.resetPassword(email: emailTextField.text!) { error in
                print(error?.localizedDescription)
            }
        }
        
    }
    
    @IBAction func resendEmail(_ sender: Any) {
        if isTextFieldsNotEmpty() {
            MUSer.resendEmailVerification(email: emailTextField.text!) { error in
                if error == nil {
                    
                }
                else {
                    print(error!.localizedDescription)
                }
            }
        }
        
    }
    
    func dismissView(){
        self.dismiss(animated: true, completion: nil)
    }
    
    private func login(withEmail:String,withPassword:String) {
        
        MUSer.loginUserWith(email: withEmail, password: withPassword) { error, isEmailVerified in
            if error == nil {
                if isEmailVerified {
//                    let profile = ProfileViewController()
//                    profile.checkLoginState()
                    self.navigationController?.popViewController(animated: true)
                } else {
                    self.hud.textLabel.text = "please verify your Email"
                    self.hud.indicatorView = JGProgressHUDErrorIndicatorView()
                    self.hud.show(in: self.view)
                    self.hud.dismiss(afterDelay: 2.0)
                }
            } else {
                self.hud.textLabel.text = "\(error!.localizedDescription)"
                self.hud.indicatorView = JGProgressHUDErrorIndicatorView()
                self.hud.show(in: self.view)
                self.hud.dismiss(afterDelay: 2.0)
            }
        }
        
    }
    private func registerUser(withEmail:String,withPassword:String) {
        
        MUSer.registerUserWith(email: withEmail, password: withPassword) { error in
            if  error == nil  {
                self.hud.textLabel.text = "varification Email sent! "
                self.hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                self.hud.show(in: self.view)
                self.hud.dismiss(afterDelay: 2.0)
                
            }   else{
                self.hud.textLabel.text = "Error\(error!.localizedDescription)"
                self.hud.indicatorView = JGProgressHUDErrorIndicatorView()
                self.hud.show(in: self.view)
                self.hud.dismiss(afterDelay: 2.0)
            }
            
        }
    }
    
    private func isTextFieldsNotEmpty()-> Bool{
        return(emailTextField.text !=  "" && passwordTextField.text != "")
    }
}
