//
//  ViewController.swift
//  AccugentixApp
//
//  Created by Bharat chowdary Kolla on 11/5/18.
//  Copyright © 2018 Bharat chowdary Kolla. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var HomeBackgroundImage: UIImageView!
    @IBOutlet weak var HomeLogoImage: UIImageView!
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var RemSwitch: UISwitch!
    @IBOutlet weak var RemLabel: UILabel!
    @IBOutlet weak var ForgotPassLabel: UILabel!
    @IBOutlet weak var SignInButton: UIButton!
    @IBOutlet weak var SignUpButton: UIButton!
    @IBOutlet weak var HomeActivityIndicator: UIActivityIndicatorView!
    //Signup Button Action
    @IBAction func SignUpButton(_ sender: UIButton) {
        sender.ButtonPulse()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
       self.performSegue(withIdentifier: "SignUpPageSegue", sender: self)
   }
}
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        //Customizing Back Button
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton

        //Customizing Buttons
        SignUpButton.ButtonDesign()
        SignInButton.ButtonDesign()
        
        //Page Title
        let hour = Calendar.current.component(.hour, from: Date())
        
        if hour >= 0 && hour < 12 {
            title = "Good Morning"
        } else if hour >= 12 && hour < 17 {
            title = "Good Afternoon"
        } else if hour >= 17 {
            title = "Good Evening"
        }
        if let userName =  UserDefaults.standard.value(forKey: "USER_NAME_KEY") as? String, userName.count > 0{
            self.EmailTextField.text = userName
        }
        
        if let password =  UserDefaults.standard.value(forKey: "PASSWORD_KEY") as? String, password.count > 0{
            self.PasswordTextField.text = password
        }
    }
    
    @IBAction func SignInPressed(_ sender: UIButton) {
        self.showLoading()
        let urlString = "http://18.191.190.126:3001/user/existing"
        var bodyparams : [String:Any] = [:]
        bodyparams["username"] = self.EmailTextField.text
        bodyparams["password"] = self.PasswordTextField.text
        
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
                        if (statusCode == 105 || statusCode == 205) {
                            sender.ButtonPulse()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                self.performSegue(withIdentifier: "SignInSuccessSegue", sender: self)
                            }
                            
                        }else if (statusCode == 106){
                            
                            let alert = UIAlertController(title: "Alert", message: successMessage, preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
    }
        
    @IBAction func SwitchStateChanged(_ sender: Any) {
        if (RemSwitch.isOn)
        {
            if let userName = EmailTextField.text, let password = PasswordTextField.text {
                UserDefaults.standard.setValue(userName, forKey: "USER_NAME_KEY")
                UserDefaults.standard.setValue(password, forKey: "PASSWORD_KEY")
                UserDefaults.standard.synchronize()
            }

        } else {
//            if let userName = EmailTextField.text, let password = PasswordTextField.text {
                UserDefaults.standard.setValue("", forKey: "USER_NAME_KEY")
                UserDefaults.standard.setValue("", forKey: "PASSWORD_KEY")
                UserDefaults.standard.synchronize()
//            }
        }
    }
    
   
func showLoading() {
    DispatchQueue.main.async {
        self.HomeActivityIndicator.startAnimating()
        self.view.isUserInteractionEnabled = false
    }
}

func hideLoading() {
    DispatchQueue.main.async {
        self.HomeActivityIndicator.stopAnimating()
        self.view.isUserInteractionEnabled = true
    }
}
}

