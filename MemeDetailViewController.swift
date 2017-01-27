//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by 윤사라 on 2017. 1. 27..
//  Copyright © 2017년 Udacity. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {

    @IBOutlet weak var selectedMemeImage: UIImageView!
    
    var selecetedMeme: Meme!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editMeme))
        self.navigationItem.rightBarButtonItem = editButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        selectedMemeImage.image = selecetedMeme.memedImage
    }

    override func viewDidDisappear(_ animated: Bool) {
        if let controller = self.navigationController{
            controller.popToRootViewController(animated: false)
        }
    }
    
    func editMeme(){
        performSegue(withIdentifier: "gotoMemeEditor", sender: nil)
        //edit 버튼누른 후, 기존의 사진을 보여주고 텍스트 수정 완료 후, save 하여 기존 사진이 대체되는 것으로?
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "gotoMemeEditor"
        {
            if let memeViewController = segue.destination as? MemeEditorViewController{
                memeViewController.editTopTextField = selecetedMeme.topText
                memeViewController.editBottomTextField = selecetedMeme.bottomText
                memeViewController.currentImage = selecetedMeme.originalImage
            }
        }
        
    }
    

}
