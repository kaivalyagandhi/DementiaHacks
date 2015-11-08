//
//  CaregiversModuleViewController.swift
//  Demestify
//
//  Created by Alexander Li on 2015-11-07.
//  Copyright © 2015 Alexander Li. All rights reserved.
//

import UIKit
import Parse

class AddPhotosViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    @IBOutlet weak var addPhotoButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    
    var imagePicker:UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
    }
    
    func configureViews() {
        
        
    }
    
    @IBAction func addPhotoButtonTapped(sender: AnyObject) {
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            //Crop image
            var posX:CGFloat
            var posY:CGFloat
            var cgwidth:CGFloat
            var cgheight:CGFloat
            
            let contextImage: UIImage = UIImage(CGImage: pickedImage.CGImage!)
            let contextSize: CGSize = contextImage.size
            if contextSize.width > contextSize.height {
                posX = ((contextSize.width - contextSize.height) / 2)
                posY = 0
                cgwidth = contextSize.height
                cgheight = contextSize.height
            } else {
                posX = 0
                posY = ((contextSize.height - contextSize.width) / 2)
                cgwidth = contextSize.width
                cgheight = contextSize.width
            }
            
            let rect: CGRect = CGRectMake(posX, posY, cgwidth, cgheight)
            
            let imageRef: CGImageRef = CGImageCreateWithImageInRect(contextImage.CGImage, rect)!
            
            let pickedImage: UIImage = UIImage(CGImage: imageRef, scale: pickedImage.scale, orientation: pickedImage.imageOrientation)
            
            //Save image to array
            savePhoto(pickedImage)

            //TODO: - Reload collectionView
            //self.imageCollectionView.reloadData()
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func savePhoto(photo:UIImage) {
        appDelegate.imageManager.addNewImage(photo)
    }
    
    @IBAction func closeButtonTapped(sender: AnyObject) {
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
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
