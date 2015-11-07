//
//  CaregiversModuleViewController.swift
//  Demestify
//
//  Created by Alexander Li on 2015-11-07.
//  Copyright © 2015 Alexander Li. All rights reserved.
//

import UIKit
import Parse

class CaregiversModuleViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var addPhotoButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    
    var imagePicker:UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    func configureViews() {
        
    }
    
    @IBAction func addPhotoButtonTapped(sender: AnyObject) {
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            //TODO: - Crop image
            
            
            
            //TODO: - Save image to array
            
            //TODO: - Reload collectionView
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func closeButtonTapped(sender: AnyObject) {
        
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
