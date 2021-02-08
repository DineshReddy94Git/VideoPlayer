//
//  UIViewExtensaion.swift
//  DemoProject
//
//  Created by K12 Services on 04/01/21.
//

import Foundation
import UIKit

extension UIView {
    
    func applyDefaultShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 3.0
        self.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
    }
    
}
