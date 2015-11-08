//
//  GameViewController.swift
//  JigsawPuzzle
//
//  Created by Arturs Derkintis on 8/19/15.
//  Copyright (c) 2015 Starfly. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //Replace with 
        //let scene = SliddingPuzzle(fileNamed: "")
        //to open sliding puzzle file
        if let scene = SliddingPuzzle(fileNamed: ""){
            // Configure the view.
            let skView = self.view as! SKView
            skView.showsFPS = true
            skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            
            skView.presentScene(scene)
            
            
            let backbutton = UIButton(frame: CGRect(x: 20, y: 20, width: 50, height: 50))
            backbutton.setImage(UIImage(named: "back-btn"), forState: .Normal)
            backbutton.addTarget(self, action: "dismiss", forControlEvents: .TouchUpInside)
            skView.addSubview(backbutton)
        }
    }
    
    func dismiss() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
