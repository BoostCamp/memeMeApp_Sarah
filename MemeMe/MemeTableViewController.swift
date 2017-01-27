//
//  MemeTableViewController.swift
//  MemeMe
//
//  Created by 윤사라 on 2017. 1. 27..
//  Copyright © 2017년 Udacity. All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController {
    
    @IBOutlet weak var addMeme: UIBarButtonItem!
    @IBOutlet var MemeTableView: UITableView!

    var memesArray :[Meme] {
        return MemeData.sharedInstance.memes
    }
    
    var memeSelected: Meme!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

    }

    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
        
    }
    
    @IBAction func addMeme(_ sender: Any) {
        performSegue(withIdentifier: "gotoMemeEditor", sender: self)
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return memesArray.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let meme = memesArray[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MemeTableCell", for: indexPath) as? MemeTableViewCell{
            cell.cellConfiguration(meme)
            return cell
        }
        else{
            return MemeTableViewCell()
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        memeSelected = memesArray[indexPath.row]
        performSegue(withIdentifier: "tableDetail", sender: nil)
    }
 
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            
            MemeData.sharedInstance.removeMeme(memeIndex: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
 
 
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "tableDetail"
        {
            if let detailViewController = segue.destination as? MemeDetailViewController{
                detailViewController.selecetedMeme = memeSelected
            }
        }
    }

    
    override func encodeRestorableState(with coder: NSCoder) {
        coder.encode(MemeData.sharedInstance.memes)
        super.encodeRestorableState(with: coder)
    }
    
    override func decodeRestorableState(with coder: NSCoder) {
        coder.decodeData()
        super.decodeRestorableState(with: coder)
    }
}
