//
//  Config.swift
//  Anagrams
//
//  Created by Caroline on 1/08/2014.
//  Copyright (c) 2013 Underplot ltd. All rights reserved.
//

import Foundation
import UIKit

//UI Constants
let ScreenWidth = UIScreen.mainScreen().bounds.size.width
let ScreenHeight = UIScreen.mainScreen().bounds.size.height



//Random number generator
func randomNumber(minX minX:UInt32, maxX:UInt32) -> Int {
  let result = (arc4random() % (maxX - minX + 1)) + minX
  return Int(result)
}

let TileMargin: CGFloat = 20.0
//comic andy
let FontHUD = UIFont(name:"Futura", size: 35.0)!
let FontHUDBig = UIFont(name:"Futura", size:50.0)!

// Sound effects
let SoundDing = "ding.mp3"
let SoundWrong = "wrong.m4a"
let SoundWin = "win.mp3"
let AudioEffectFiles = [SoundDing, SoundWrong, SoundWin]
