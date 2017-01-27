//
//  MemeData.swift
//  MemeMe
//
//  Created by 윤사라 on 2017. 1. 27..
//  Copyright © 2017년 Udacity. All rights reserved.
//

import Foundation

class MemeData{
    
    static let sharedInstance = MemeData()
    
    var _memes = [Meme]()
    
    var memes: [Meme]{
        get{
            return _memes
        }
    }
    
    //save meme to current meme array
    func saveMemes(meme: Meme)
    {
        _memes.append(meme)
    }
    
    //remove meme from current meme array
    
    func removeMeme(memeIndex: Int)
    {
        _memes.remove(at: memeIndex)
    }
}
