//
//  ViewController.swift
//  Demestify
//
//  Created by Alexander Li on 2015-11-07.
//  Copyright © 2015 Alexander Li. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController, StoreViewControllerDelegate {
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

    @IBOutlet weak var shopButton: UIButton!
    
    @IBOutlet weak var healthBarButton: UIButton!
    @IBOutlet weak var healthBarImageView: UIImageView!
    var hbImageView:UIImageView!
    @IBOutlet weak var moneyBarButton: UIButton!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var caregiverModuleButton: UIButton!
    @IBOutlet weak var petImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        
        if PFUser.currentUser() == nil {
            enableAllButtons(false)
            PFAnonymousUtils.logInWithBlock({ (user, error) -> Void in
                self.enableAllButtons(true)
            })
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        animateHealthBar()
        animateMoneyLabel()
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
    
    func configurePetImageView() {
        
        
        var jumpImages:[UIImage] = []
        for idx in 0..<9 {
            jumpImages.append(UIImage(named: "Sprites__00\(idx.description)")!)
        }
        
        petImageView.animationImages = jumpImages
        petImageView.animationRepeatCount = 2
        petImageView.animationDuration = 0.7
        petImageView.startAnimating()
        self.performSelector("animatePetImageView", withObject: nil, afterDelay: 0.7)
        
    }
    
    func animatePetImageView() {
        petImageView.animationImages = nil
        petImageView.image = UIImage(named: "Sprites__001")
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
    func storeViewControllerDidPurchase() {
        self.dismissViewControllerAnimated(true) { () -> Void in
            self.animateMoneyLabel()
            self.animateHealthBar()
        }
    }
}

