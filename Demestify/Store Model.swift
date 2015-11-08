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
            cost = 2500
            health = 27
        
        case .Corn:
            name = "Corn"
            cost = 500
            health = 5
        
        case .Chicken:
            name = "Chicken"
            cost = 2000
            health = 22
        
        case .Pizza:
            name = "Pizza"
            cost = 2000
            health = 22

        case .Fries:
            name = "Fries"
            cost = 500
            health = 5
        
        case .Bread:
            name = "Bread"
            cost = 300
            health = 3
            
        case .Cotton_Candy:
            name = "Cotton Candy"
            cost = 700
            health = 8
        
        case .Sandwich:
            name = "Sandwich"
            cost = 4200
            health = 47
            
        case .Hamburger:
            name = "Hamburger"
            cost = 4000
            health = 45
            
        case .Spaghetti:
            name = "Spaghetti"
            cost = 3000
            health = 34
            
        case .Milkshake:
            name = "Milkshake"
            cost = 300
            health = 3

        case .Coffee:
            name = "Coffee"
            cost = 100
            health = 1
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
            cost = 5000
            bodyPosition = .Head
        
        case .Diaper:
            name = "Diaper"
            cost = 6000
            bodyPosition = .Legs
        
        case .Cape:
            name = "Cape"
            cost = 7000
            bodyPosition = .Torso
        
        case .Dress:
            name = "Dress"
            cost = 12000
            bodyPosition = .Torso
        
        case .Blouse:
            name = "Blouse"
            cost = 7000
            bodyPosition = .Torso
        
        case .Skirt:
            name = "Skirt"
            cost = 7000
            bodyPosition = .Legs
        
        case .Shirt:
            name = "Shirt"
            cost = 5000
            bodyPosition = .Torso
        
        case .Toque:
            name = "Toque"
            cost = 3500
            bodyPosition = .Head
        
        case .HairTie:
            name = "Hair Tie"
            cost = 3000
            bodyPosition = .Head
        
        case .Fedora:
            name = "Fedora"
            cost = 6500
            bodyPosition = .Head
        
        case .EarMuffs:
            name = "Ear Muffs"
            cost = 7500
            bodyPosition = .Head
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