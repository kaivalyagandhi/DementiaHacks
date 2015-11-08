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
    
    func deleteAnagram(item:AnagramModel, completion:(index:Int) -> Void) {
        if anagrams.contains(item) {
            let index = anagrams.indexOf(item)!
            deleteAnagramAtIndex(index)
            completion(index: index)
        }
    }
    
    func deleteAnagramAtIndex(index:Int) {
        anagrams.removeAtIndex(index)
    }
    
    func addAnagram(question:String, answer:String) {
        let newAnagram = AnagramModel(answer: answer, question: question)
        self.anagrams.insert(newAnagram, atIndex: 0)
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