//
//  GameController.swift
//  Anagrams
//
//  Created by Caroline Begbie on 12/04/2015.
//  Copyright (c) 2015 Caroline. All rights reserved.
//

import Foundation
import UIKit

class GameController {
  var gameView: UIView!
  var level: Level!
  
  private var tiles = [TileView]()
  private var targets = [TargetView]()
  
  var hud:HUDView! {
    didSet {
      //connect the Hint button
      hud.hintButton.addTarget(self, action: Selector("actionHint"), forControlEvents:.TouchUpInside)
      hud.hintButton.enabled = false
    }
  }
  
  //stopwatch variables
  private var secondsLeft: Int = 0
  private var timer: NSTimer?
  
  private var data = GameData()
  
  private var audioController: AudioController
  
  var onAnagramSolved:( () -> ())!
  
  init() {
    self.audioController = AudioController()
    self.audioController.preloadAudioEffects(AudioEffectFiles)
  }
    
    func randomStringWithLength(anagramToJumble : String) -> NSString{
        let letters : NSString = anagramToJumble;
        
        let randomString : NSMutableString = NSMutableString(capacity: letters.length)
        
        for (var i=0; i < letters.length; i++){
            let length = UInt32 (letters.length)
            let rand = arc4random_uniform(length)
            randomString.appendFormat("%C", letters.characterAtIndex(Int(rand)))
        }
        
        return randomString
    }
  
  func dealRandomAnagram () {
    //1
    assert(level.anagrams.count > 0, "no level loaded")
    
    //2
    let randomIndex = randomNumber(minX:0, maxX:UInt32(level.anagrams.count-1))
    let anagramPair = level.anagrams[randomIndex]
    
    //3
    let anagram1 = anagramPair[0] as! String
    let anagram2 = anagramPair[1] as! String
    let anagram3 = anagramPair[2] as! String
    
    //4
   
    let anagram1length = anagram1.characters.count
    let anagram2length = anagram2.characters.count
    let anagram3length = anagram3.characters.count
    
    //5
    print("phrase1[\(anagram1length)]: \(anagram1)")
    print("phrase2[\(anagram2length)]: \(anagram2)")
    
    //calculate the tile size
    let tileSide = ceil(ScreenWidth * 0.9 / CGFloat(max(anagram1length, anagram2length))) - TileMargin
    
    //get the left margin for first tile
    var xOffset = (ScreenWidth - CGFloat(max(anagram1length, anagram2length)) * (tileSide + TileMargin)) / 2.0
    
    //adjust for tile center (instead of the tile's origin)
    xOffset += tileSide / 2.0
    
    //initialize target list
    targets = []
    
    //create targets
    for (index, letter) in anagram2.characters.enumerate() {
      if letter != " " {
        let target = TargetView(letter: letter, sideLength: tileSide)
        target.center = CGPointMake(xOffset + CGFloat(index)*(tileSide + TileMargin), ScreenHeight/4)
        
        gameView.addSubview(target)
        targets.append(target)
      }
    }
    
    //1 initialize tile list
    tiles = []
    
    //2 create tiles
    for (index, letter) in anagram1.characters.enumerate() {
      //3
      if letter != " " {
        let tile = TileView(letter: letter, sideLength: tileSide)
        tile.center = CGPointMake(xOffset + CGFloat(index)*(tileSide + TileMargin), ScreenHeight/4*2)
        
        tile.randomize()
        tile.dragDelegate = self
        
        //4
        gameView.addSubview(tile)
        tiles.append(tile)
      }
    }
    
    let questionLabel = UILabel(frame: CGRectMake(10, 10, 850, 300))
    questionLabel.center = CGPointMake(ScreenWidth/2, 3*ScreenHeight/4)
    questionLabel.numberOfLines = 0
    questionLabel.font = FontHUD
    questionLabel.text = anagram3

    gameView.addSubview(questionLabel)
    
    //start the timer
    self.startStopwatch()
    
    hud.hintButton.enabled = true
    
  }
  
  func placeTile(tileView: TileView, targetView: TargetView) {
    //1
    targetView.isMatched = true
    tileView.isMatched = true
    
    //2
    tileView.userInteractionEnabled = false
    
    //3
    UIView.animateWithDuration(0.35,
      delay:0.00,
      options:UIViewAnimationOptions.CurveEaseOut,
      //4
      animations: {
        tileView.center = targetView.center
        tileView.transform = CGAffineTransformIdentity
      },
      //5
      completion: {
        (value:Bool) in
        targetView.hidden = true
    })
    
    let explode = ExplodeView(frame:CGRectMake(tileView.center.x, tileView.center.y, 10,10))
    tileView.superview?.addSubview(explode)
    tileView.superview?.sendSubviewToBack(explode)
  }
  
  
  
  func checkForSuccess() {
    for targetView in targets {
      //no success, bail out
      if !targetView.isMatched {
        return
      }
    }
    print("Game Over!")
    
    hud.hintButton.enabled = false
    
    //stop the stopwatch
    self.stopStopwatch()
    
    //the anagram is completed!
    audioController.playEffect(SoundWin)
    
    // win animation
    let firstTarget = targets[0]
    let startX:CGFloat = 0
    let endX:CGFloat = ScreenWidth + 300
    let startY = firstTarget.center.y
    
    let stars = StardustView(frame: CGRectMake(startX, startY, 10, 10))
    gameView.addSubview(stars)
    gameView.sendSubviewToBack(stars)
    
    UIView.animateWithDuration(3.0,
      delay:0.0,
      options:UIViewAnimationOptions.CurveEaseOut,
      animations:{
        stars.center = CGPointMake(endX, startY)
      }, completion: {(value:Bool) in
        //game finished
        stars.removeFromSuperview()

        //when animation is finished, show menu
        self.clearBoard()
        self.onAnagramSolved()
    })
  }

  func startStopwatch() {
    //initialize the timer HUD
    secondsLeft = level.timeToSolve
    hud.stopwatch.setSeconds(secondsLeft)
    
    //schedule a new timer
    timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector:"tick:", userInfo: nil, repeats: true)
  }
  
  func stopStopwatch() {
    timer?.invalidate()
    timer = nil
  }
  
  @objc func tick(timer: NSTimer) {
    secondsLeft--
    hud.stopwatch.setSeconds(secondsLeft)
    if secondsLeft == 0 {
      self.stopStopwatch()
    }
  }
  
  //the user pressed the back button
    @objc func actionBack(){
     hud.backButton.enabled = false
        
       // gameView.cancel()

    //self dismissViewControllerAnimated:FALSE completion:nil
    }
  //the user pressed the hint button
  @objc func actionHint() {
    //1
    hud.hintButton.enabled = false
    
    //2
    data.points -= level.pointsPerTile / 2
    hud.gamePoints.setValue(data.points, duration: 1.5)
    
    //3 find the first unmatched target and matching tile
    var foundTarget:TargetView? = nil
    for target in targets {
      if !target.isMatched {
        foundTarget = target
        break
      }
    }
    
    //4 find the first tile matching the target
    var foundTile:TileView? = nil
    for tile in tiles {
      if !tile.isMatched && tile.letter == foundTarget?.letter {
        foundTile = tile
        break
      }
    }
    
    //ensure there is a matching tile and target
    if let target = foundTarget, tile = foundTile {
      
      //5 don't want the tile sliding under other tiles
      gameView.bringSubviewToFront(tile)
      
      //6 show the animation to the user
      UIView.animateWithDuration(1.5,
        delay:0.0,
        options:UIViewAnimationOptions.CurveEaseOut,
        animations:{
          tile.center = target.center
        }, completion: {
          (value:Bool) in
          
          //7 adjust view on spot
          self.placeTile(tile, targetView: target)
          
          //8 re-enable the button
          self.hud.hintButton.enabled = true
          
          //9 check for finished game
          self.checkForSuccess()
          
      })
    }
  }
  
  //clear the tiles and targets
  func clearBoard() {
    tiles.removeAll(keepCapacity: false)
    targets.removeAll(keepCapacity: false)
    
    for view in gameView.subviews  {
      view.removeFromSuperview()
    }
  }
  
}

extension GameController:TileDragDelegateProtocol {
  //a tile was dragged, check if matches a target
  func tileView(tileView: TileView, didDragToPoint point: CGPoint) {
    var targetView: TargetView?
    for tv in targets {
      if tv.frame.contains(point) && !tv.isMatched {
        targetView = tv
        break
      }
    }
    
    //1 check if target was found
    if let targetView = targetView {
      
      //2 check if letter matches
      if targetView.letter == tileView.letter {
        
        //3
        self.placeTile(tileView, targetView: targetView)

        //more stuff to do on success here
        
        audioController.playEffect(SoundDing)
        
        //give points
        data.points += level.pointsPerTile
        hud.gamePoints.setValue(data.points, duration: 0.5)
        
        //check for finished game
        self.checkForSuccess()
      
      } else {
        
        //4
        //1
        tileView.randomize()
        
        //2
        UIView.animateWithDuration(0.35,
          delay:0.00,
          options:UIViewAnimationOptions.CurveEaseOut,
          animations: {
            tileView.center = CGPointMake(tileView.center.x + CGFloat(randomNumber(minX:0, maxX:40)-20),
              tileView.center.y + CGFloat(randomNumber(minX:20, maxX:30)))
          },
          completion: nil)
        
        //more stuff to do on failure here
        
        audioController.playEffect(SoundWrong)
        
        //take out points
        data.points -= level.pointsPerTile/2
        hud.gamePoints.setValue(data.points, duration: 0.25)
      }
    }
    
  }
  

}
