//
//  Store Constants.swift
//  Demestify
//
//  Created by Alexander Li on 2015-11-07.
//  Copyright © 2015 Alexander Li. All rights reserved.
//

import UIKit
//TODO: Add the rest of the food and clothing enums

struct Food {
    var name:String!
    var cost:Int!
    var health:Int!
    
    init(foodType:FoodTypes) {
        switch foodType {
        case .Sushi:
            name = "Sushi"
            cost = 2000
            health = 40
            
        default:
            break
        }
    }
}

struct Clothing {
    var name:String!
    var cost:Int!
    var bodyPosition:BodyPosition!
    
    init(clothingType:ClothingTypes) {
        switch clothingType {
        case .Scarf:
            name = "Scarf"
            cost = 20
            bodyPosition = .Head
            
            
        default:
            break
        }
    }
}

enum FoodTypes:Int {
    case Sushi = 0, Corn, Chicken, Pizza, Fries, Bread, Cotton_Candy, Sandwich, Hamburger, Spaghetti, Milkshake, Coffee
}

enum ClothingTypes {
    case Scarf, HairTie, Fedora, EarMuffs, Toque, Shirt, Skirt, Blouse, Dress, Cape, Diaper
}

enum BodyPosition {
    case Head, Torso, Legs
}