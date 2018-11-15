//
//  CustomerRegViewController.swift
//  AccugentixApp
//
//  Created by Bharat chowdary Kolla on 11/5/18.
//  Copyright © 2018 Bharat chowdary Kolla. All rights reserved.
//

import UIKit

class CustomerRegViewController: UIViewController {
    @IBOutlet weak var FirstName: UITextField!
    @IBOutlet weak var CustomerUsername: UITextField!
    @IBOutlet weak var LastName: UITextField!
    @IBOutlet weak var EmailAdd: UITextField!
    @IBOutlet weak var PasswordText1: UITextField!
    @IBOutlet weak var PasswordText: UITextField!
    @IBOutlet weak var SerialNumber: UITextField!
    @IBOutlet weak var SerailNoLabel: UILabel!
    @IBOutlet weak var StateLabel: UILabel!
    @IBOutlet weak var StateText: UITextField!
    @IBOutlet weak var CustomerSignUpButton: UIButton!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Customer Sign Up"
        self.navigationItem.setHidesBackButton(true, animated:true);
        
        let rightSideOptionButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(Customercancelbutton))
        self.navigationItem.rightBarButtonItem = rightSideOptionButton
        
        CustomerSignUpButton.ButtonDesign()
        
    }
    
    //Cancel button
    @objc func Customercancelbutton()
    {
        let alertController = UIAlertController(title: "Just Checking", message: "Are You Sure You Want to Start over ", preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: { (action: UIAlertAction!) in
            
            self.navigationController?.popToRootViewController(animated: true)
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
   
    
    //Email Field Validation
    @IBAction func EmailAddEditFinish(_ sender: Any) {
        let email = EmailAdd.isValidEmail(EmailStr: EmailAdd.text!)
        if (email == false)
        {
            Alert(Message: "Please Enter A Valid Email Address")
        }
    }
    
    //Sign up button function
    @IBAction func CustomerSIgnUpAct(_ sender: UIButton) {
        
        if (FirstName.text?.count == 0 || LastName.text?.count == 0 || EmailAdd.text?.count == 0 || CustomerUsername.text?.count == 0 || PasswordText.text?.count == 0 || StateText.text?.count == 0 || SerialNumber.text?.count == 0) {
            sender.ButtonShake()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.Alert(Message: "All Fields Required")
            }
            
        } else if (PasswordText.text != PasswordText1.text) {
            sender.ButtonShake()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.Alert(Message: "Please Check Passwords")
            }
        } else {
             //CustomerSignUpButton.isHidden = false
            self.showLoading()
            let urlString = "http://18.191.190.126:3001/user/new"
            var bodyparams : [String:Any] = [:]
            bodyparams["first_name"] = self.FirstName.text
           bodyparams["last_name"] = self.LastName.text
            bodyparams["email"] = self.EmailAdd.text
            bodyparams["password"] = self.PasswordText.text
            bodyparams["serial_number"] = self.SerialNumber.text
            bodyparams["state"] = self.StateText.text
            bodyparams["type"] = "customer"
            bodyparams["username"] = self.CustomerUsername.text
            
            RequestHandler.sharedInstance.requestDataFromUrl(urlName: urlString, httpMethodType: "POST", body: bodyparams) { (responseData, err) in
                
                DispatchQueue.main.async {
                    self.hideLoading()
                    var successMessage = ""
                    var statusCode = 0
                    if err == nil, let responseDict = responseData {
                        successMessage = (responseDict["message"] as? String) ?? ""
                        statusCode = responseDict["status"] as? Int ?? 0
                        
                    } else {
                       successMessage = err?.localizedDescription ?? ""
                    }
                    if successMessage.count > 0 {
                            let alert = UIAlertController(title: "Alert", message: successMessage, preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action: UIAlertAction!) in
                                if statusCode == 103 {
                                    self.navigationController?.popToRootViewController(animated: true)
                                }
                            }))
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                }
        }
    }

    func Alert(Message: String){
        let alertController = UIAlertController(title: "OOPS !!!", message: Message, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil ))
        self.present(alertController, animated: true, completion: nil)

    }
    
    func showLoading() {
        DispatchQueue.main.async {
            self.loadingIndicator.startAnimating()
            self.view.isUserInteractionEnabled = false
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            self.loadingIndicator.stopAnimating()
            self.view.isUserInteractionEnabled = true
        }
    }
}

