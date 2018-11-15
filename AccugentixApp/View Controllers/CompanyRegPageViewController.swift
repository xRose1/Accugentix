//
//  CompanyRegPageViewController.swift
//  AccugentixApp
//
//  Created by Bharat chowdary Kolla on 11/6/18.
//  Copyright © 2018 Bharat chowdary Kolla. All rights reserved.
//

import UIKit

class CompanyRegPageViewController: UIViewController {

    @IBOutlet weak var RegBackground: UIImageView!
    @IBOutlet weak var CompanyName: UITextField!
    @IBOutlet weak var CompanyUserName: UITextField!
    @IBOutlet weak var CompanyEmail: UITextField!
    @IBOutlet weak var CompanyPassword: UITextField!
    @IBOutlet weak var CConfirmPassword: UITextField!
    @IBOutlet weak var CompanyRegCode: UITextField!
    @IBOutlet weak var CompanyNoteLabel: UILabel!
    @IBOutlet weak var CompanySignUp: UIButton!
    @IBOutlet weak var LoadingIndicator: UIActivityIndicatorView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Company Sign Up"
        self.navigationItem.setHidesBackButton(true, animated:true);
        let rightSideOptionButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(Companycancelbutton))
        self.navigationItem.rightBarButtonItem = rightSideOptionButton
        
        CompanySignUp.ButtonDesign()
    }
    
    @objc func Companycancelbutton()
    {
        let alertController = UIAlertController(title: "Just Checking", message: "Are You Sure You Want to Start over ", preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: { (action: UIAlertAction!) in
            
            self.navigationController?.popToRootViewController(animated: true)
            
        }))
        
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    @IBAction func CompanyEmailEditAction(_ sender: Any) {
        let email = CompanyEmail.isValidEmail(EmailStr: CompanyEmail.text!)
        if (email == false)
        {
            Alert(Message: "Please Enter A Valid Email Address")
        }
    }
    @IBAction func CompanySignUpButton(_ sender: UIButton) {
        
        if (CompanyUserName.text?.count == 0 || CompanyEmail.text?.count == 0 || CompanyPassword.text?.count == 0 || CompanyRegCode.text?.count == 0 || CompanyName.text?.count == 0 || CConfirmPassword.text?.count == 0) {
            sender.ButtonShake()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.Alert(Message: "All Fields Required")
            }
            
        } else if (CompanyPassword.text != CConfirmPassword.text) {
            sender.ButtonShake()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.Alert(Message: "Please Check Passwords")
            }
        } else {
            self.showLoading()

        let urlString = "http://18.191.190.126:3001/user/new"
        var bodyparams : [String:Any] = [:]
        bodyparams["username"] = self.CompanyUserName.text
        bodyparams["password"] = self.CompanyPassword.text
        bodyparams["email"] = self.CompanyEmail.text
        bodyparams["type"] = "company"
        bodyparams["company_name"] = self.CompanyName.text
        bodyparams["company_code"] = self.CompanyRegCode.text
        
        RequestHandler.sharedInstance.requestDataFromUrl(urlName: urlString, httpMethodType: "POST", body: bodyparams) { (responseData, err) in
            
            DispatchQueue.main.async
                {
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
                    self.LoadingIndicator.startAnimating()
                    self.view.isUserInteractionEnabled = false
                }
            }
            
            func hideLoading() {
                DispatchQueue.main.async {
                    self.LoadingIndicator.stopAnimating()
                    self.view.isUserInteractionEnabled = true
                }
            }
}
