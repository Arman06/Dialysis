//
//  addViewController.swift
//  Dyal
//
//  Created by Арман on 9/24/18.
//  Copyright © 2018 Арман. All rights reserved.
//

import UIKit

class addViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageContainer: UIView!
    
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var pickImageButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        if let image = imageContainer.viewWithTag(110) as? UIImageView {
            image.image = UIImage(named: DataService.instance.getFood()[0].imageName)
            image.layer.cornerRadius = 13
            image.layer.masksToBounds = true
        }
        imageContainer.layer.cornerRadius = 13
        imageContainer.layer.masksToBounds = true
//        imageContainer.layer.masksToBounds = false
//        imageContainer.layer.shadowColor = UIColor.black.cgColor
//        imageContainer.layer.shadowOffset = CGSize(width: 2, height: 15)
//        imageContainer.layer.shadowOpacity = 0.1
//        imageContainer.layer.shadowRadius = 4.0
    }

    @IBAction func pickImageTapped(_ sender: UIButton) {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Источник фото", message: "Выберите фото", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Камера", style: .default, handler: { (action: UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            }
            

        }))
        actionSheet.addAction(UIAlertAction(title: "Галерея", style: .default, handler: { (action: UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        //actionSheet.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        actionSheet.popoverPresentationController?.sourceView = self.view
        actionSheet.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection()
        actionSheet.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
        //self.present(actionSheet, animated: true)
        self.present(actionSheet, animated: true, completion: nil)
        
    }

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        if let imagePresentation = imageContainer.viewWithTag(110) as? UIImageView {
            imagePresentation.image = image
        }
        
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}
