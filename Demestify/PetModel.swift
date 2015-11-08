//
//  PetModel.swift
//  Demestify
//
//  Created by Alexander Li on 2015-11-07.
//  Copyright © 2015 Alexander Li. All rights reserved.
//

import UIKit

class PetModel: NSObject {

    var petMoney:Int?
    var petHealth:Int?
    var purchasedClothing:[Int] = []
    
    override init() {
        petMoney = NSUserDefaults.standardUserDefaults().integerForKey("petMoney")
        if petMoney == 0 {
            petMoney = 1000
        }
        petHealth = NSUserDefaults.standardUserDefaults().integerForKey("petHealth")
        if petHealth == 0 {
            petHealth = 90
        }
        
        if let foundPurchasedClothing = NSUserDefaults.standardUserDefaults().objectForKey("purchasedClothing") {
            purchasedClothing = foundPurchasedClothing as! [Int]
        }
    }
    
    func saveData() {
        if petMoney != nil {
        NSUserDefaults.standardUserDefaults().setInteger(petMoney!, forKey: "petMoney")
        }
        if petHealth != nil {
        NSUserDefaults.standardUserDefaults().setInteger(petHealth!, forKey: "petHealth")
        }

        NSUserDefaults.standardUserDefaults().setObject(purchasedClothing, forKey: "purcahsedClothing")
    }
    
    func incrementMoney(byAmount:Int) {
        petMoney! += byAmount
    }
    
    func incrementHealth(byAmount:Int) {
        
        //TODO: - Check for death
        petHealth! += byAmount
    }
    
    func purchaseClothing(item:Int) {
        purchasedClothing.append(item)
    }
}