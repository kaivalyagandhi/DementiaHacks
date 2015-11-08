//
//  ViewController.swift
//  Anagrams
//
//  Created by Caroline on 1/08/2014.
//  Copyright (c) 2014 Caroline. All rights reserved.
//

import UIKit

class AnagramViewController: UIViewController, HUDViewDelegate {
  
  private let controller:GameController
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        controller = GameController()
        super.init(nibName: nil, bundle: nil)
    }
    
  required init?(coder aDecoder: NSCoder) {
    controller = GameController()
    super.init(coder: aDecoder)
  }
    
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //add one layer for all game elements
    let gameView = UIView(frame: CGRectMake(0, 0, ScreenWidth, ScreenHeight))
    self.view.addSubview(gameView)
    controller.gameView = gameView

    //add one view for all hud and controls
    let hudView = HUDView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight))
    hudView.delegate = self
    
    let backgroundView = UIView(frame: CGRectMake(0, 0, ScreenWidth, ScreenHeight))
    hudView.insertSubview(backgroundView, atIndex: 0)
    
    self.view.addSubview(hudView)
    controller.hud = hudView

    controller.onAnagramSolved = self.showLevelMenu
  }
  
  //show the game menu on app start
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    self.showLevelMenu()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  override func prefersStatusBarHidden() -> Bool {
    return true
  }

  func showLevelMenu() {
    self.showLevel(1)
  }
  
  //5 show the appropriate level selected by the player
  func showLevel(levelNumber:Int) {
    controller.level = Level(levelNumber: levelNumber)
    controller.dealRandomAnagram()
  }
    
    func HUDViewDelegateDidCancel() {
        self.dismissViewControllerAnimated(false, completion: nil)
    }
  
}

