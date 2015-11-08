//
//  Enums.swift
//  puzzleGame
//
//  Created by Arturs Derkintis on 8/11/15.
//  Copyright © 2015 Starfly. All rights reserved.
//

import Foundation


enum NumberLevels : Int {
    case easy   = 3
   // case medium =
   // case hard   = 12
   // case insane = 16
   // case areyoukiddingme = 20
}
enum ImageLevels : Int {
    case easy   = 3
  //  case normal = 6
  //  case hard   = 8
}
enum TileMoves{
    case up, down, right, left, notMove
}

//MARK: Things for JigSaw Puzzle

enum JigsawLevels : Int{
    case easy   = 2
    case normal = 3
    case hard = 4
//    case normal = 3
//    case hard   = 3
}
enum PieceRotation : Int{
    case zero   = 0     //correct
    case first  = 1     //90d
    case second = 2     //180d
    case third  = 3     //270d
}
struct ConectionTags {
    var top     : Int = 0
    var right   : Int = 0
    var bottom  : Int = 0
    var left    : Int = 0
}