//
//  MemeTableViewCell.swift
//  MemeMe
//
//  Created by 윤사라 on 2017. 1. 27..
//  Copyright © 2017년 Udacity. All rights reserved.
//

import UIKit

class MemeTableViewCell: UITableViewCell {

    @IBOutlet weak var memeImage: UIImageView!
    @IBOutlet weak var topTextLabel: UILabel!
    @IBOutlet weak var bottomTextLabel: UILabel!
    @IBOutlet weak var topImageLabel: UILabel!
    @IBOutlet weak var bottomImageLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        memeImage.contentMode = UIViewContentMode.scaleAspectFit
        memeImage.clipsToBounds = true
        
        accessoryType = UITableViewCellAccessoryType.disclosureIndicator
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func cellConfiguration(_ meme: Meme)
    {
        let top = meme.topText
        let bottom = meme.bottomText
        
        textStyle(top!, label: topImageLabel)
        textStyle(bottom!, label: bottomImageLabel)
        
        memeImage.image = meme.originalImage
        topTextLabel.text = top
        bottomTextLabel.text = bottom
    }
    

}
