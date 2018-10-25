//
//  ViewController.swift
//  OpenCV
//
//  Created by BinaryBoy on 10/24/18.
//  Copyright © 2018 BinaryBoy. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let wrapper:OpenCVWrapper = OpenCVWrapper()
        let version  = wrapper.getVersion()
        print(version ?? "fail to get opencv version")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func takePhoto(_ sender: UIBarButtonItem) {
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            // Only allow photos to be picked, not taken.
            imagePickerController.sourceType = .camera
            
            // Make sure ViewController is notified when the user picks an image.
            imagePickerController.delegate = self
            present(imagePickerController, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func edgeImage(_ sender: UIBarButtonItem) {
        imageView.image = ImageManager.getEdgeImage(orginImage: imageView?.image ?? #imageLiteral(resourceName: "image"))
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let takenImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        // Set imageView to display the selected image.
        imageView.image = takenImage
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    

}

