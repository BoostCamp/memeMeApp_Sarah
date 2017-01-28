//
//  keyBoardMove.swift
//  MemeMe
//
//  Created by 윤사라 on 2017. 1. 28..
//  Copyright © 2017년 Udacity. All rights reserved.
//

import Foundation
import UIKit

class KeyBoardMove: NSObject {
    
    var view: UIView?
    var elements: [UIResponder] = []
    let notificationCenter = NotificationCenter.default
    
    /*
     * Subscribe to keyboard moving
     */
    func subscribeToKeyboardNotifications(_ view: UIView, elements: [UIResponder]) {
        self.view = view
        self.elements = elements
        
        notificationCenter.addObserver(self, selector: #selector(KeyBoardMove.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        notificationCenter.addObserver(self, selector: #selector(KeyBoardMove.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    /*
     * Unsubscribe from keyboard moving
     */
    func unsubscribeFromKeyboardNotifications() {
        notificationCenter.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        notificationCenter.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    /*
     * Move view above keyboard
     */
    func keyboardWillShow(_ notification: Notification) {
        for element in elements {
            if element.isFirstResponder {
                self.view?.frame.origin.y = 1 - getKeyboardHeight(notification)
                return
            }
        }
    }
    
    /*
     * Move view back to the bottom of the screen
     */
    func keyboardWillHide(_ notification: Notification) {
        self.view?.frame.origin.y = 0
    }
}
