//
//  UIButtonExtension.swift
//  AccugentixApp
//
//  Created by Bharat chowdary Kolla on 11/8/18.
//  Copyright © 2018 Bharat chowdary Kolla. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    func ButtonDesign()
    {
        
        self.layer.cornerRadius = self.frame.height/2
    }
    func ButtonPulse(){
        
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.6
        pulse.fromValue = 0.95
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = 2
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        layer.add(pulse, forKey: nil)
    }
    
    func Buttonflash(){
        
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.5
        flash.fromValue = 1
        flash.toValue = 0.1
        flash.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = 2
        layer.add(flash, forKey: nil)
    }
    func ButtonShake() {
        
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.2
        shake.autoreverses = true
        shake.repeatCount = 1
        
        let fromPoint = CGPoint(x: center.x - 5, y: center.y)
        let fromValue = NSValue(cgPoint:fromPoint)
        
        let toPoint = CGPoint(x: center.x + 5, y: center.y)
        let toValue = NSValue(cgPoint:toPoint)


        
        shake.fromValue = fromValue
        shake.toValue = toValue
        
        
        layer.add(shake, forKey: nil)
        
    }
}
