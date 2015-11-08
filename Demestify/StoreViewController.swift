//
//  StoreViewController.swift
//  Demestify
//
//  Created by Alexander Li on 2015-11-07.
//  Copyright © 2015 Alexander Li. All rights reserved.
//

import UIKit

protocol StoreViewControllerDelegate {
    func storeViewControllerDidPurchaseFood()
}

class StoreViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var delegate:StoreViewControllerDelegate?
    
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
    
    @IBAction func categorySegmentedControllerChanged(sender: AnyObject) {
        collectionView.reloadData()
    }
    
    //MARK: CollectionViewDelegate
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if categorySegmentedControl.selectedSegmentIndex == 0 {
             return FoodTypes.count
        } else if categorySegmentedControl.selectedSegmentIndex == 1 {
            return ClothingTypes.count
        } else {
            return 0
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if categorySegmentedControl.selectedSegmentIndex == 0 {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("FoodItemCell", forIndexPath: indexPath) as? FoodItemCollectionViewCell
            cell?.foodItem = Food(foodType: indexPath.item)
            cell?.configureCell()
            return cell!

        } else {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ClothingItemCell", forIndexPath: indexPath) as? ClothingItemCollectionViewCell
            cell!.clothingItem = Clothing(clothingType: indexPath.item)
            cell!.own = appDelegate.pet.purchasedClothing.contains({indexPath.item}())
            cell?.configureCell()
            return cell!
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("tapped")
        if categorySegmentedControl.selectedSegmentIndex == 0 && appDelegate.pet.petMoney > Food(foodType: indexPath.item).cost {
            appDelegate.pet.incrementHealth(Food(foodType: indexPath.item).health)
            appDelegate.pet.incrementMoney(-Food(foodType: indexPath.item).cost)

            if delegate != nil {
                delegate?.storeViewControllerDidPurchaseFood()
            }
        } else if categorySegmentedControl.selectedSegmentIndex == 1 && appDelegate.pet.petMoney > Clothing(clothingType: indexPath.item).cost && appDelegate.pet.purchasedClothing.contains({indexPath.item}()) == false {
            appDelegate.pet.purchaseClothing(indexPath.item)
            appDelegate.pet.incrementMoney(-Clothing(clothingType: indexPath.item).cost)
            collectionView.reloadItemsAtIndexPaths([NSIndexPath(forItem: indexPath.item, inSection: 0)])
        } else {
            return
        }
    }
    
    @IBAction func closeItemTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
