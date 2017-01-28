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
    
    var meme: Meme!

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        selectedMemeImage.image = meme.memedImage
    }

    @IBAction func editMeme(_ sender: UIBarButtonItem) {
        
        let controller = storyboard!.instantiateViewController(withIdentifier: "MemeEditorViewController") as! MemeEditorViewController
        
        controller.meme = meme
        
        present(controller, animated:true, completion: nil)
    }
    
    
}

