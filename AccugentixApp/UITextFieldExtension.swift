//
//  UITextFieldExtension.swift
//  AccugentixApp
//
//  Created by Bharat chowdary Kolla on 11/15/18.
//  Copyright © 2018 Bharat chowdary Kolla. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    func isValidEmail(EmailStr:String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let Email = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return Email.evaluate(with: EmailStr)
}
}
