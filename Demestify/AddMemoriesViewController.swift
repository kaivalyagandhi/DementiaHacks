//
//  AddMemoriesViewController.swift
//  Demestify
//
//  Created by Alexander Li on 2015-11-08.
//  Copyright © 2015 Alexander Li. All rights reserved.
//

import UIKit

class AddMemoriesViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate, AnagramTableViewCellDelegate {

    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var charactersRemainingLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        questionTextView.delegate = self
        answerTextField.delegate = self
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        self.view.addGestureRecognizer(tapGestureRecognizer)
        
        configureViews()
    }
    
    @IBAction func dismissButtonTapped(sender: AnyObject) {
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func dismissKeyboard() {
        questionTextView.resignFirstResponder()
        answerTextField.resignFirstResponder()
    }
    
    func configureViews() {
        configureQuestionTextView()
        configureAnswerTextField()
        configureCharactersRemainingLabel()
        configureSubmitButton()
    }
    
    func configureQuestionTextView() {
        questionTextView.layer.borderColor = UIColor.blackColor().colorWithAlphaComponent(0.1).CGColor
        questionTextView.layer.borderWidth = 1
        questionTextView.layer.cornerRadius = 5
        questionTextView.textColor = UIColor.blackColor().colorWithAlphaComponent(0.2)
        questionTextView.text = "Question Here"
    }
    
    func configureAnswerTextField() {
        answerTextField.placeholder = "Answer Here"
    }
    
    func configureCharactersRemainingLabel() {
        charactersRemainingLabel.text = (20 - (answerTextField.text?.utf8.count)!).description + " characters remaining"
        
    }
    
    func configureSubmitButton() {
        submitButton.enabled = false
    }
    
    @IBAction func submitButtonTapped(sender: AnyObject) {
        appDelegate.anagramManager.addAnagram(questionTextView.text, answer: answerTextField.text!)
        tableView.insertRowsAtIndexPaths([NSIndexPath(forItem: 0, inSection: 0)], withRowAnimation: .Left)
    }
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        if textView.text == "Question Here" {
            textView.text = ""
        }
        
        textView.textColor = UIColor.blackColor()
        return true
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        configureCharactersRemainingLabel()
        submitButton.enabled = textField.text?.utf8.count > 3
        return true
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        
        if range.length >= 20 && strcmp(text.cStringUsingEncoding(NSUTF8StringEncoding)!,"\\b") != -92 {
            return false
        }
        
        return true
    }
    
    func textViewShouldEndEditing(textView: UITextView) -> Bool {
        if textView.text.utf8.count == 0 {
            questionTextView.textColor = UIColor.blackColor().colorWithAlphaComponent(0.2)
        }
        return true
    }
    
    //MARK: Table View
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "EXISTING MEMORIES"
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appDelegate.anagramManager.anagrams.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("anagramCell", forIndexPath: indexPath) as! AnagramTableViewCell
        
        let anagram = appDelegate.anagramManager.anagrams[indexPath.row]
        
        cell.anagram = anagram
        cell.delegate = self
        
        cell.questionLabel.text = anagram.question
        cell.answerLabel.text = anagram.answer
        
        return cell
    }
    
    func anagramTableViewCellDidDeleteAnagram(item: AnagramModel) {
        appDelegate.anagramManager.deleteAnagram(item) { (index) -> Void in
            self.tableView.reloadData()
        }
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
