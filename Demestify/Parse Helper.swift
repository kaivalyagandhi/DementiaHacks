//
//  Parse Helper.swift
//  Demestify
//
//  Created by Alexander Li on 2015-11-07.
//  Copyright © 2015 Alexander Li. All rights reserved.
//

import UIKit
import Parse

func saveAnagramPlayData(time:NSTimeInterval, isCorrect:Bool, numberOfHints:Int) {
    let newData = PFObject(className: PF_ANAGRAM_CLASSNAME)
    newData[PF_ANAGRAM_COMPLETED] = isCorrect
    newData[PF_ANAGRAM_HINTS] = numberOfHints
    newData[PF_ANAGRAM_TIME] = Float(time)
    if PFUser.currentUser() != nil {
        newData[PF_ANAGRAM_FROMUSER] = PFUser.currentUser()!
    }
    newData.saveInBackgroundWithBlock { (success, error) -> Void in
        if error == nil && success == true {
            print("Saved anagram data")
        }
    }
}

func saveJigsawPlayData(time:NSTimeInterval, isCorrect:Bool) {
    let newData = PFObject(className: PF_ANAGRAM_CLASSNAME)
    newData[PF_ANAGRAM_COMPLETED] = isCorrect
    newData[PF_ANAGRAM_TIME] = Float(time)
    if PFUser.currentUser() != nil {
        newData[PF_ANAGRAM_FROMUSER] = PFUser.currentUser()!
    }
    newData.saveInBackgroundWithBlock { (success, error) -> Void in
        if error == nil && success == true {
            print("Saved jigsaw data")
        }
    }
}