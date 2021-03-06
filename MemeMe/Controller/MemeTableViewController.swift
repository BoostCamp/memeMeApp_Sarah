//
//  MemeTableViewController.swift
//  MemeMe
//
//  Created by 윤사라 on 2017. 1. 27..
//  Copyright © 2017년 Udacity. All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController {

    var memes = MemeData.sharedInstance.memes
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let showMemes = loadMemes(){
            memes += showMemes
        }
        else
        {
            print("nothing to show")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let meme = memes[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeTableCell") as? MemeTableViewCell
            
            cell?.topTextLabel.text = meme.topText
            cell?.bottomTextLabel.text = meme.bottomText
            cell?.memeImage.image = meme.memedImage
            
            return cell!
    
        }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
 
        let controller = storyboard?.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        
        controller.meme = memes[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
 
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            memes.remove(at: indexPath.row)
            saveMemes()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    //NSCoding
    func saveMemes()
    {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(memes, toFile: Meme.MemeClass.ArchiveURL.path)
        if !isSuccessfulSave{
            print("fail to save memes")
        }
        else{
            print("success to save memes")
        }
    }
    
    func loadMemes() -> [Meme]?{
        return NSKeyedUnarchiver.unarchiveObject(withFile: Meme.MemeClass.ArchiveURL.path) as? [Meme]
    }
    
}
