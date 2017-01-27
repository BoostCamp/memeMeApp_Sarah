//
//  Constants.swift
//  MemeMe
//
//  Created by 윤사라 on 2017. 1. 27..
//  Copyright © 2017년 Udacity. All rights reserved.
//

import UIKit

func textStyle(_ text:String, label:UILabel)
{
    let textStyled = NSAttributedString(string:text, attributes:[NSStrokeColorAttributeName:UIColor.black, NSStrokeWidthAttributeName:-2.0])
    label.attributedText = textStyled
}
