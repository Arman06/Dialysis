//
//  addViewController.swift
//  Dyal
//
//  Created by Арман on 9/24/18.
//  Copyright © 2018 Арман. All rights reserved.
//

import UIKit
import Photos
import PhotosUI

class addViewController: UIViewController, UINavigationControllerDelegate {
    
    
    var namePassed : String?
    var sodiumPassed : String?
    var potassiumPassed : String?
    var imageNewPassed : UIImage?
    
    @IBOutlet weak var outerStackView: UIStackView!
    @IBOutlet weak var topStackViewConstraint: NSLayoutConstraint!
    var topStackViewConstraintConstantHolder: CGFloat = 0.0
    
    @IBOutlet weak var addButton: BlueRoundButton!
    @IBOutlet weak var imageNew: UIImageView!
    
    @IBOutlet weak var potassiumTextField: UITextField!
    @IBOutlet weak var sodiumTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    var imagePicker = UIImagePickerController()
    
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var pickImageButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        textFieldsSetup()
        configureTapGesture()
        addNotificationObserevers()
        topStackViewConstraint.constant = view.frame.height / 15
        topStackViewConstraintConstantHolder = topStackViewConstraint.constant
        imageNew.image = UIImage(named: DataService.instance.getFood()[0].imageName)
        imageNew.layer.cornerRadius = 13
        imageNew.layer.masksToBounds = true
        addButton.addTarget(self, action: #selector(addTapped(_:)), for: .touchUpInside)
    }

    @objc func addTapped(_ sender: UIButton) {
        print("add tapped")
        imageNewPassed = imageNew.image
    }
    
    func addNotificationObserevers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification: )), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let info = notification.userInfo {
            let keyboardRect: CGRect = info["UIKeyboardFrameEndUserInfoKey"] as! CGRect
            if keyboardRect.height > 0 {
                let difference = self.view.frame.height - (self.topStackViewConstraintConstantHolder + self.outerStackView.frame.height + keyboardRect.height + 15)
                if difference < 0 {
                    self.topStackViewConstraint.constant = self.topStackViewConstraintConstantHolder - abs(difference)
                }
                UIView.animate(withDuration: 0.4, delay: 0.1, usingSpringWithDamping: 0.7, initialSpringVelocity: 2, options: .curveEaseOut, animations: {
                    self.view.layoutIfNeeded()
                }, completion: nil)
            }
        }
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        self.topStackViewConstraint.constant = self.topStackViewConstraintConstantHolder
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.75, initialSpringVelocity: 2, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func configureTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    
    
    func pickImageControllerConfigure() {
        
        DispatchQueue.main.async {

            self.imagePicker.allowsEditing = true
            let actionSheet = UIAlertController(title: "Источник фото", message: "Выберите фото", preferredStyle: .actionSheet)
            actionSheet.addAction(UIAlertAction(title: "Камера", style: .default, handler: { (action: UIAlertAction) in
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    self.imagePicker.sourceType = .camera
                    self.imagePicker.showsCameraControls = true
                    self.imagePicker.delegate = self
                    self.present(self.imagePicker, animated: true, completion: nil)
                }
                
                
            }))
            actionSheet.addAction(UIAlertAction(title: "Галерея", style: .default, handler: { (action: UIAlertAction) in
                self.imagePicker.sourceType = .photoLibrary
                self.imagePicker.delegate = self
                self.present(self.imagePicker, animated: true, completion: nil)
            }))
            
            actionSheet.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
            actionSheet.popoverPresentationController?.sourceView = self.view
            actionSheet.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection()
            actionSheet.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            
            self.present(actionSheet, animated: true, completion: nil)
        }
        
    }
    
    func checkingAuthStatusPhotoLibrary() {
        let photoAuthorizationStatus =  PHPhotoLibrary.authorizationStatus()
        if photoAuthorizationStatus == .authorized {
            print("authorized")
            pickImageControllerConfigure()
        } else {
            PHPhotoLibrary.requestAuthorization { (status:PHAuthorizationStatus) -> Void in
                if status == .denied {
                    print("denied in addViewController")
                    
                }
                if status == .restricted {print("restricted in addViewController")}
                if status == .authorized {self.pickImageControllerConfigure()}
            }
            
        }
    }
    
    
    
    
    
//    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
//        if reason == .committed {
//            print("hello")
//        }
//    }
    
    @IBAction func pickImageTapped(_ sender: UIButton) {
        view.endEditing(true)
        checkingAuthStatusPhotoLibrary()
    }
}

extension addViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == nameTextField {
            namePassed = textField.text
        }
        if textField == sodiumTextField {
            sodiumPassed = textField.text
        }
        
        if textField == potassiumTextField {
            potassiumPassed = textField.text
        }
        
    }
    
    
    func textFieldsSetup(){
        nameTextField.delegate = self
        sodiumTextField.delegate = self
        sodiumTextField.keyboardType = .default
        potassiumTextField.delegate = self
        potassiumTextField.keyboardType = .default
    }
    
    
}

extension addViewController: UIImagePickerControllerDelegate {
    @objc func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            imageNew.image = editedImage
            imageNewPassed = imageNew.image
        } else {
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
                imageNew.image = image
                imageNewPassed = imageNew.image
                
            }
        }
        self.dismiss(animated: true, completion: nil)
    }
}
