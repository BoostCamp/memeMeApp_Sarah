//
//  MemeEditorViewController.swift
//  MemeMe
//
//  Created by 윤사라 on 2017. 1. 28..
//  Copyright © 2017년 Udacity. All rights reserved.
//


import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imagePicker: UIImageView!
    
 
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    @IBOutlet weak var bottomToolbar: UIToolbar!
    @IBOutlet weak var albumButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    @IBOutlet weak var topToolbar: UIToolbar!
    @IBOutlet weak var actionButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    let keyBoardMove = KeyBoardMove()
    let topTextDelegate = MemeTextFieldDelegate()
    let bottomTextDelegate = MemeTextFieldDelegate()
    
    var meme = Meme()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        actionButton.isEnabled = false
        
        setTextField(topTextField, text: meme.topText, delegate:topTextDelegate)
        setTextField(bottomTextField, text: meme.bottomText, delegate:bottomTextDelegate)
        
        if let image = meme.originalImage{
            imageLoad(image)
            (topTextField.delegate as! MemeTextFieldDelegate).isTextDefault = false
            (topTextField.delegate as! MemeTextFieldDelegate).isTextDefault = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        keyBoardMove.subscribeToKeyboardNotifications(view, elements:[bottomTextField])
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        keyBoardMove.unsubscribeFromKeyboardNotifications()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    //textfield
    func setTextField(_ element: UITextField, text: String, delegate: UITextFieldDelegate)
    {
        let memeTextAttributes:[String:Any] = [
            
            NSStrokeColorAttributeName : UIColor.black,
            NSForegroundColorAttributeName : UIColor.white,
            NSFontAttributeName: UIFont(name:"HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName : -8.0
        ]
       
        element.text = text
        element.delegate = delegate
        element.defaultTextAttributes = memeTextAttributes
        element.textAlignment = .center
        element.isHidden = true
    }
    
    //share button
    @IBAction func pressAction(_ sender: UIBarButtonItem) {
    
        let image = generateMemedImage()
        let controller = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        
        controller.completionWithItemsHandler = { activity, success, items, error in
            if success{
                self.saveMemedImage(image)
                self.dismiss(animated: true, completion: nil)
            }
        }
        
        self.present(controller, animated: true, completion: nil)
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
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            imageLoad(image)
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: false, completion: nil)
    }
    
    func imageLoad(_ image:UIImage)
    {
        imagePicker.image = image
        bottomTextField.isHidden = false
        topTextField.isHidden = false
        actionButton.isEnabled = true
    }
    
    
    func saveMemedImage(_ image: UIImage)
    {
        meme.topText = topTextField.text!
        meme.bottomText = bottomTextField.text!
        meme.originalImage = imagePicker.image!
        meme.memedImage = image
        (UIApplication.shared.delegate as! AppDelegate).memes.append(meme)
    }
    
    func generateMemedImage() -> UIImage
    {
        var image = UIImage()
        
            if view.restorationIdentifier == "meme"{
                UIGraphicsBeginImageContext(self.view.frame.size)
                
               let statusBarHeight = (view.window?.convert(UIApplication.shared.statusBarFrame, from:view))!.height
               let toolbarHeight = topToolbar.frame.height
               let context = UIGraphicsGetCurrentContext()
                context?.translateBy(x: 0, y: -(statusBarHeight + toolbarHeight))
                
                view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
                image = UIGraphicsGetImageFromCurrentImageContext()!
                UIGraphicsEndImageContext()
        }
        
        return image
    }
   /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        meme = Meme(topText: meme.topText, bottomText: meme.bottomText, originalImage: meme.originalImage, memedImage: meme.memedImage )
    }
*/
}

