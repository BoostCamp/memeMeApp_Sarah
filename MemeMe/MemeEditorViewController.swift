//
//  MemeEditorViewController.swift
//  MemeMe
//
//  Created by 윤사라 on 2017. 1. 18..
//  Copyright © 2017년 Udacity. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    
    @IBOutlet weak var imagePicker: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
   
    //bottom bar
    @IBOutlet weak var bottomToolbar: UIToolbar!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var albumButton: UIBarButtonItem!
    
    //top bar
    @IBOutlet weak var actionButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    
    
    let memeTextAttributes:[String:Any] = [
        
        NSStrokeColorAttributeName : UIColor.black,
        NSForegroundColorAttributeName : UIColor.white,
        NSFontAttributeName: UIFont(name:"HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName : -8.0
    ]
    
    let topTextFieldDefault = "TOP"
    let bottomTextFieldDefault = "BOTTOM"
    
    var editTopTextField: String?
    var editBottomTextField: String?
    
    var memedImage: UIImage!
    var currentImage: UIImage!
    
    let memesArray = MemeData.sharedInstance.memes
   
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        actionButton.isEnabled = false
       
        setTextField(topTextField)
        setTextField(bottomTextField)
        
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if currentImage != nil{
            imageSet()
            if let top = editTopTextField, let bottom = editBottomTextField{
                topTextField.text = top
                bottomTextField.text = bottom
            }
        }
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
        
    }
    
    //share button
    @IBAction func pressAction(_ sender: Any) {
        let image = generateMemedImage()
        let controller = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        self.present(controller, animated: true, completion: nil)
        controller.completionWithItemsHandler = { activity, success, items, error in
            if success{
                self.save()
                self.dismiss(animated: true, completion: nil)
            }
        }
    }

    //cancel button
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    //pick image from library
    @IBAction func pickAnImageAlbum(_ sender: Any) {
        imagePickerPresent(.photoLibrary)
    }

    
    //take photo from camera
    @IBAction func pickAnImageCamera(_ sender: Any) {
        imagePickerPresent(.camera)
    }
    
    func imagePickerPresent(_ chosenSource: UIImagePickerControllerSourceType)
    {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = chosenSource
        self.present(picker, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
 
        currentImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        imageSet()
        dismiss(animated: true, completion: nil)
    }
    
   func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: false, completion: nil)
    }
    
    func imageSet()
    {
        imagePicker.image = currentImage
        actionButton.isEnabled = true
    }
    
    
    func save()
    {
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: currentImage, memedImage: memedImage)
        
        MemeData.sharedInstance.saveMemes(meme: meme)
        
    }
    
    func generateMemedImage() -> UIImage
    {
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        hideToolbar(false)
        
        return memedImage
    }
    
    //textfield
    func setTextField(_ textFeild: UITextField)
    {
        textFeild.delegate = self
        textFeild.defaultTextAttributes = memeTextAttributes
        textFeild.textAlignment = .center
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField.text! {
        case topTextFieldDefault,bottomTextFieldDefault:
            textField.text = ""
        default:
            break
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == ""
        {
            if textField == topTextField{
                textField.text = topTextFieldDefault
            }
            else if textField == bottomTextField{
                textField.text = bottomTextFieldDefault
            }
        }}
    
    //keyboard

    func keyboardWillShow(_ notification:Notification)
    {
        if bottomTextField.isEditing{
            self.view.frame.origin.y = 1 - getKeyboardHeight(notification)
        }
    }
    
    
    func keyboardWillHide(_ notification:Notification)
    {
        if bottomTextField.isEditing {
            self.view.frame.origin.y = 0
        }
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    func subscribeToKeyboardNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications(){
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    
    func hideToolbar(_ state:Bool)
    {
        self.navigationController?.isNavigationBarHidden = state
        bottomToolbar.isHidden = state
    }
}

