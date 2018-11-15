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
    }
    
}


