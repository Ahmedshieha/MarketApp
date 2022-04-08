//
//  PaymentViewController.swift
//  MarketApp
//
//  Created by MacBook on 08/04/2022.
//

import UIKit
import Stripe
import SwiftUI




class PaymentViewController: UIViewController {

    @IBOutlet weak var doneButton: UIButton!
    var delegate : CardInfoViewControllerDelegate?
    let paymentTextField = STPPaymentCardTextField()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(paymentTextField)
        configurePaymentTextField()
    }
    
    @IBAction func cancleButton(_ sender: Any) {
        delegate?.Cancle()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneButton(_ sender: Any) {
        processCard()
    }
    
    func configurePaymentTextField() {
        paymentTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraint(NSLayoutConstraint(item: paymentTextField, attribute: .top, relatedBy: .equal, toItem: doneButton, attribute: .bottom, multiplier: 1, constant: 30))
        view.addConstraint(NSLayoutConstraint(item: paymentTextField, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -20))
        view.addConstraint(NSLayoutConstraint(item: paymentTextField, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 20))
    }
    
     private func processCard() {
        let cardParm = STPCardParams()
         cardParm.number = paymentTextField.cardNumber
         cardParm.expMonth = UInt(paymentTextField.expirationMonth)
         cardParm.expYear = UInt(paymentTextField.expirationYear)
         cardParm.cvc = paymentTextField.cvc
         cardParm.addressZip = paymentTextField.postalCode
         
         STPAPIClient.shared.createToken(withCard: cardParm) { token, error in
             if error == nil {
                 self.delegate?.Done(token!)
                 self.dismiss(animated: true, completion: nil)
             } else {
                 print(error!.localizedDescription)
             }
         }
    }
    
    
}
extension PaymentViewController : STPPaymentCardTextFieldDelegate {
    
    func paymentCardTextFieldDidChange(_ textField: STPPaymentCardTextField) {
    }
}

protocol CardInfoViewControllerDelegate {
    func Done(_ token : STPToken)
    func Cancle()
}
