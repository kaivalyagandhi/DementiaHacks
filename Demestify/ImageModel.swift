//
//  ImageModel.swift
//  Demestify
//
//  Created by Alexander Li on 2015-11-07.
//  Copyright © 2015 Alexander Li. All rights reserved.
//
import UIKit

class ImageStore: NSObject, NSCoding {
    
    var dataFilePath: String?
    var images:[UIImage] = []
    
    override init() {
        let manager = NSFileManager.defaultManager()
        let url = manager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first
        dataFilePath = url!.URLByAppendingPathComponent("imagesArray").path!
        
        if manager.fileExistsAtPath(dataFilePath!) {
            print("Getting urls from archive")
            images = NSKeyedUnarchiver.unarchiveObjectWithFile(dataFilePath!) as! [UIImage]
            print("found " + images.count.description + " images")
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        images = aDecoder.decodeObjectForKey("images") as! [UIImage]
        print("found " + images.count.description + " images")
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(images, forKey: "images")
    }
    
    func saveData() {
        NSKeyedArchiver.archiveRootObject(images, toFile: dataFilePath!)
    }
    
    func addNewImage(image:UIImage) {
        images.insert(image, atIndex: 0)
        saveData()
    }
    
    func deleteImage(image:UIImage) {
        if images.contains(image) {
            deleteIdeaAtIndex(images.indexOf(image)!)
        }
    }
    
    func deleteIdeaAtIndex(index:Int) {
        images.removeAtIndex(index)
    }
    
    
}



