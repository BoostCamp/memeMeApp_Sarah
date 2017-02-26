//
//  MemeData.swift
//  MemeMe
//
//  Created by 윤사라 on 2017. 1. 31..
//  Copyright © 2017년 Udacity. All rights reserved.
//

import Foundation
import UIKit

class MemeData {
    
    static let sharedInstance = MemeData()
    
    var memes :[Meme] {
        return (UIApplication.shared.delegate as! AppDelegate).memes
    }

}
