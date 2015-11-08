//
//  ViewController.swift
//  Demestify
//
//  Created by Alexander Li on 2015-11-07.
//  Copyright © 2015 Alexander Li. All rights reserved.
//

import UIKit
import Parse
import AVFoundation
import AudioToolbox

class ViewController: UIViewController, StoreViewControllerDelegate {
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var gameMode = 0
    
    
    @IBOutlet weak var shopButton: UIButton!
    
    @IBOutlet weak var healthBarButton: UIButton!
    @IBOutlet weak var healthBarImageView: UIImageView!
    var hbImageView:UIImageView!
    @IBOutlet weak var moneyBarButton: UIButton!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var caregiverModuleButton: UIButton!
    @IBOutlet weak var petImageView: UIImageView!
    @IBOutlet weak var headClothingImage: UIImageView!
    @IBOutlet weak var torsoClothingImage: UIImageView!
    
    var audioPlayer:AVAudioPlayer!
    let path = NSURL(fileURLWithPath: NSString(format: "%@/Elvis Presley - Hound Dog - Cover Version  (Instrumental).mp3", NSBundle.mainBundle().resourcePath!) as String)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureClothing()
        if PFUser.currentUser() == nil {
            enableAllButtons(false)
            PFAnonymousUtils.logInWithBlock({ (user, error) -> Void in
                self.enableAllButtons(true)
            })
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOfURL: path)
        } catch {
            print("no audio file")
        }
        
        audioPlayer.play()
    }
    
    override func viewDidAppear(animated: Bool) {
        animateHealthBar()
        animateMoneyLabel()
    }
    
    func configureClothing() {
        let headTapRecognizer = UITapGestureRecognizer(target: self, action: "toggleClothingHead:")
        headClothingImage.addGestureRecognizer(headTapRecognizer)
        let torsoTapRecognizer = UITapGestureRecognizer(target: self, action: "toggleClothingTorso:")
        torsoClothingImage.addGestureRecognizer(torsoTapRecognizer)
        headClothingImage.image = nil
        torsoClothingImage.image = nil
    }
    
    func toggleClothingHead(gesture:UITapGestureRecognizer) {
        print("toggle head")
        var allClothing:[Clothing] = []
        for idx in 0..<ClothingTypes.count {
            allClothing.append(Clothing(clothingType: idx))
        }
        
        let filteredClothing = allClothing.filter({$0.bodyPosition == BodyPosition.Head})
        
        let idx = arc4random_uniform(UInt32(filteredClothing.count))
        let image = UIImage(named: filteredClothing[Int(idx)].name.lowercaseString + "_image")
        headClothingImage.image = image
    }
    
    func toggleClothingTorso(gesture:UITapGestureRecognizer) {
        var allClothing:[Clothing] = []
        for idx in 0..<ClothingTypes.count {
            allClothing.append(Clothing(clothingType: idx))
        }
        
        let filteredClothing = allClothing.filter({$0.bodyPosition == BodyPosition.Torso})
        
        let idx = arc4random_uniform(UInt32(filteredClothing.count))
        let image = UIImage(named: filteredClothing[Int(idx)].name.lowercaseString + "_image")
        torsoClothingImage.image = image
    }
    
    func enableAllButtons(enable:Bool) {
        healthBarButton.enabled = enable
        shopButton.enabled = enable
        moneyBarButton.enabled = enable
        playButton.enabled = enable
        caregiverModuleButton.enabled = enable
    }
    
    //MARK: - Configure Views
    func configureViews() {
        configureHealthBar()
        configureMoneyLabel()
        configurePetImageView()
    }
    
    func configureHealthBar() {
        healthBarImageView.hidden = true
        
        hbImageView = UIImageView(frame: CGRect(x: healthBarImageView.frame.origin.x, y: healthBarImageView.frame.origin.y, width: 0 * healthBarImageView.frame.width, height: healthBarImageView.frame.height))
        hbImageView.image = UIImage(named: "healthBar-inside")
        
        self.view.addSubview(hbImageView)
    }
    
    func animateHealthBar() {
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.hbImageView.frame = CGRect(x: self.healthBarImageView.frame.origin.x, y: self.healthBarImageView.frame.origin.y, width: min(CGFloat(self.appDelegate.pet.petHealth!), 100.0)  * self.healthBarImageView.frame.width/100, height: self.healthBarImageView.frame.height)
            }) { (finished) -> Void in
        }
    }
    
    func configureMoneyLabel() {
        moneyLabel.text = appDelegate.pet.petMoney?.description
    }
    
    func animateMoneyLabel() {
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.moneyLabel.text = self.appDelegate.pet.petMoney?.description
            }) { (finished) -> Void in
                
        }
    }
    
    func animateEating() {
        let feeling = "chew"
        
        var animImages:[UIImage] = []
        for idx in 1..<10 {
            animImages.append(UIImage(named: "\(feeling)-\(idx.description)")!)
        }
        
        petImageView.animationImages = animImages
        petImageView.animationRepeatCount = 3
        petImageView.animationDuration = 0.9
        petImageView.startAnimating()
        self.performSelector("resetPetImageView", withObject: nil, afterDelay: 0.9)
    }
    
    func configurePetImageView() {
        var feeling:String!
        switch appDelegate.pet.petHealth! {
        case 0..<30:
            feeling = "supersad"
        case 30..<60:
            feeling = "sad"
        case 60..<80:
            feeling = "okay"
        case 80..<100:
            feeling = "happy"
        default:
            feeling = "okay"
        }
        
        var animImages:[UIImage] = []
        for idx in 1...10 {
            animImages.append(UIImage(named: "\(feeling)-\(idx.description)")!)

        }
        
        petImageView.animationImages = animImages
        petImageView.animationRepeatCount = 3
        petImageView.animationDuration = 0.9
        petImageView.startAnimating()
        self.performSelector("resetPetImageView", withObject: nil, afterDelay: 0.9)
    }
    
    func resetPetImageView() {
        petImageView.animationImages = nil
        petImageView.image = UIImage(named: "okay-1")
        self.performSelector("configurePetImageView", withObject: nil, afterDelay: 3)
    }
    
    //MARK: Buttons
    @IBAction func healthButtonTapped(sender: AnyObject) {
        let alert = UIAlertController(title: nil, message: "Get more health by buying food", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func moneyButtonTapped(sender: AnyObject) {
        let alert = UIAlertController(title: nil, message: "Get more money by playing games", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func shopButtonTapped(sender: AnyObject) {
        self.performSegueWithIdentifier("presentStoreFormSegue", sender: nil)
    }
    
    @IBAction func playButtonTapped(sender: AnyObject) {
        self.performSegueWithIdentifier("presentJigsawSegue", sender: nil)
        return
        if gameMode == 0 {
            self.performSegueWithIdentifier("presentAnagramSegue", sender: nil)
            gameMode = 1
        } else {
            gameMode = 0
        }
    }

    @IBAction func caregiversModuleButtonTapped(sender: AnyObject) {
        performSegueWithIdentifier("presentCaregiverSegue", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "presentStoreFormSegue" {
            let storeVC = segue.destinationViewController as! StoreViewController
            storeVC.delegate = self
        }
    }
    
    //StoreViewController Delegate
    func storeViewControllerDidPurchaseFood() {
        self.dismissViewControllerAnimated(true) { () -> Void in
            self.animateMoneyLabel()
            self.animateHealthBar()
            self.animateEating()
        }
    }
}

