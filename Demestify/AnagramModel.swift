//
//  AnagramModel.swift
//  Demestify
//
//  Created by Alexander Li on 2015-11-07.
//  Copyright © 2015 Alexander Li. All rights reserved.
//

import UIKit

class AnagramStore: NSObject, NSCoding {
    
    var dataFilePath: String?
    var anagrams:[AnagramModel] = []
    
    override init() {
        let manager = NSFileManager.defaultManager()
        let url = manager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first
        dataFilePath = url!.URLByAppendingPathComponent("anagramsArray").path!
        
        if manager.fileExistsAtPath(dataFilePath!) {
            print("Getting urls from archive")
            anagrams = NSKeyedUnarchiver.unarchiveObjectWithFile(dataFilePath!) as! [AnagramModel]
            print("found " + anagrams.count.description + " anagrams")
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        anagrams = aDecoder.decodeObjectForKey("anagrams") as! [AnagramModel]
        print("found " + anagrams.count.description + " anagrams")
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(anagrams, forKey: "anagrams")
    }
    
    func saveAnagrams() {
        NSKeyedArchiver.archiveRootObject(anagrams, toFile: dataFilePath!)
    }
    
    func deleteAnagram(item:AnagramModel) {
        if anagrams.contains(item) {
            deleteAnagramAtIndex(anagrams.indexOf(item)!)
        }
    }
    
    func deleteAnagramAtIndex(index:Int) {
        anagrams.removeAtIndex(index)
    }
}

class AnagramModel: NSObject, NSCoding {
    
    var answer:String?
    var question:String?
    
    init(answer:String, question:String) {
        self.answer = answer
        self.question = question
    }
    
    required init?(coder aDecoder: NSCoder) {
        answer = aDecoder.decodeObjectForKey("answer") as? String
        question = aDecoder.decodeObjectForKey("question") as? String
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(answer, forKey: "answer")
        aCoder.encodeObject(question, forKey: "question")
    }
}