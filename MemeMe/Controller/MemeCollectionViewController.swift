//
//  MemeCollectionViewController.swift
//  MemeMe
//
//  Created by 윤사라 on 2017. 1. 27..
//  Copyright © 2017년 Udacity. All rights reserved.
//

import UIKit

class MemeCollectionViewController: UICollectionViewController{

    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    var memes = MemeData.sharedInstance.memes
    
    override func viewDidLoad() {
        super.viewDidLoad()
        composeFlowLayout()
        
        if let showMemes = loadMemes()
        {
        memes += showMemes
        }
        else{
            print("nothing to show")
        }
    }

    func composeFlowLayout ()
    {
        let space: CGFloat = 3.0
        let dimension = (self.view.frame.size.width - (2 * space)) / 3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView?.reloadData()
        composeFlowLayout()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let meme = memes[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionViewCell", for: indexPath) as! MemeCollectionViewCell
        cell.memeImage.image = meme.memedImage
        
        return cell
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let collectionController = storyboard?.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        collectionController.meme = memes[indexPath.row]
        saveMemes()
        navigationController?.pushViewController(collectionController, animated: true)

    }
    
    //NSCoding
    func saveMemes()
    {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(memes, toFile: Meme.MemeClass.ArchiveURL.path)
        if !isSuccessfulSave{
            print("fail to save memes")
        }
        else{
            print("sucess to save memes")
        }
    }
    
    func loadMemes() -> [Meme]?{
        return NSKeyedUnarchiver.unarchiveObject(withFile: Meme.MemeClass.ArchiveURL.path) as? [Meme]
    }

}
