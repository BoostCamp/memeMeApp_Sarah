//
//  MemeTextFieldDelegate.swift
//  MemeMe
//
//  Created by 윤사라 on 2017. 1. 28..
//  Copyright © 2017년 Udacity. All rights reserved.
//

import Foundation
import UIKit

class MemeTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    var isTextDefault: Bool = true
    

    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if isTextDefault {
            textField.text = ""
            isTextDefault = false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
}


