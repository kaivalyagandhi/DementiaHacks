//
//  StoreViewController.swift
//  Demestify
//
//  Created by Alexander Li on 2015-11-07.
//  Copyright © 2015 Alexander Li. All rights reserved.
//

import UIKit

class StoreViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var categorySegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.collectionView.registerNib(UINib(nibName: "FoodItemCollectionViewCell", bundle: NSBundle.mainBundle()), forCellWithReuseIdentifier: "FoodItemCell")
        self.collectionView.registerNib(UINib(nibName: "ClothingItemCollectionViewCell", bundle: NSBundle.mainBundle()), forCellWithReuseIdentifier: "ClothingItemCell")
        self.collectionView.backgroundColor = UIColor.clearColor()
        self.collectionView.backgroundView?.backgroundColor = UIColor.clearColor()
    }
    
    func purchaseClothing(item:Clothing) {
        
    }
    
    func purchaseFood(item:Food) {
        
    }
    
    @IBAction func categorySegmentedControllerChanged(sender: AnyObject) {
        
    }
    
    //MARK: CollectionViewDelegate
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
                
        if categorySegmentedControl.selectedSegmentIndex == 0 {
             return 1
        } else if categorySegmentedControl.selectedSegmentIndex == 1 {
            return 1
        } else {
            return 1
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        var cell:UICollectionViewCell!
        
        if categorySegmentedControl.selectedSegmentIndex == 0 {
            cell = collectionView.dequeueReusableCellWithReuseIdentifier("FoodItemCell", forIndexPath: indexPath) as? FoodItemCollectionViewCell
        } else {
            cell = collectionView.dequeueReusableCellWithReuseIdentifier("ClothingItemCell", forIndexPath: indexPath) as? ClothingItemCollectionViewCell
        }
        
        return cell
    }
    
    
    @IBAction func closeItemTapped(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
