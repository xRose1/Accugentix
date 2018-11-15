//
//  RegisterationViewController.swift
//  AccugentixApp
//
//  Created by Bharat chowdary Kolla on 11/5/18.
//  Copyright © 2018 Bharat chowdary Kolla. All rights reserved.
//

import UIKit

class RegisterationViewController: UIViewController {

    @IBOutlet weak var RegPageBackGround: UIImageView!
    
    @IBOutlet weak var CustomerSignUpButton: UIButton!
    
    @IBOutlet weak var CustomerNoteLabel: UILabel!
    
    @IBOutlet weak var CompanySignUpButton: UIButton!
    
    @IBOutlet weak var CompanyNoteLabel: UILabel!
    
    @IBAction func CustomerSignUpNav(_ sender: UIButton) {
        sender.Buttonflash()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        self.performSegue(withIdentifier: "CustomerRegPageSegue", sender: self)
        }
    }
    
    @IBAction func CompanySignUpNav(_ sender: UIButton) {
        
        sender.Buttonflash()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        self.performSegue(withIdentifier: "CompanyRegPageSegue", sender: nil)
    }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Sign Up"

        
        //Custom Title
//        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Arial", size: 20)!]

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
