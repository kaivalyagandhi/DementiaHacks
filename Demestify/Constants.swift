//
//  Constants.swift
//  Demestify
//
//  Created by Alexander Li on 2015-11-07.
//  Copyright © 2015 Alexander Li. All rights reserved.
//

import UIKit
import Parse

let PF_APPLICATIONKEY = "vyuW0y1a9mLqnNLbbmVjDDv0BKGheERXKUEVhA0y"
let PF_CLIENTKEY = "u08uNsd4KvsgGWt4wxWxMYPm4vb8xLhhQqENpuI9"

let petAnimations = ["chew", "jump", "okay", "sad", "supersad", "happy"]

//MARK: - Parse anagram save data
let PF_ANAGRAM_CLASSNAME = "Anagram"
let PF_ANAGRAM_FROMUSER = "fromUser" //_User
let PF_ANAGRAM_TIME = "time" //Float
let PF_ANAGRAM_HINTS = "hints" //Int
let PF_ANAGRAM_COMPLETED = "completed" //Bool


let pieceName = "Pieces98"
struct Layer {
    static let Background   : CGFloat = 1
    static let GuidePhoto   : CGFloat = 2
    static let Tiles        : CGFloat = 3
    static let MenuItems    : CGFloat = 4
    static let MovingPiece  : CGFloat = 5
}
