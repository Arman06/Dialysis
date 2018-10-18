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
        imageNew.image = UIImage(named: "Image-placeholder.jpg")
        imageNew.layer.cornerRadius = 13
        imageNew.layer.masksToBounds = true
    }

    @IBAction func addTapped(_ sender: UIButton) {
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
            let actionSheet = UIAlertController(title: "Источник фото", message: "Выберите фото", preferredStyle: .actionSheet)
            actionSheet.addAction(UIAlertAction(title: "Камера", style: .default, handler: { (action: UIAlertAction) in
                let status = self.checkingCameraAuthStatus()
                print("\(status)" + " ohohoho")
                if status {
                    if UIImagePickerController.isSourceTypeAvailable(.camera) {
                        self.imagePicker.sourceType = .camera
                        self.imagePicker.allowsEditing = true
                        self.imagePicker.showsCameraControls = true
                        self.imagePicker.delegate = self
                        self.present(self.imagePicker, animated: true, completion: nil)
                    }
                }
            }))
            actionSheet.addAction(UIAlertAction(title: "Галерея", style: .default, handler: { (action: UIAlertAction) in
                
                if self.checkingAuthStatusPhotoLibrary() {
                    self.imagePicker.sourceType = .photoLibrary
                    self.imagePicker.allowsEditing = true
                    self.imagePicker.delegate = self
                    self.present(self.imagePicker, animated: true, completion: nil)
                }
            }))
            
            actionSheet.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
            actionSheet.popoverPresentationController?.sourceView = self.view
            actionSheet.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection()
            actionSheet.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            //DispatchQueue.main.async {
            self.present(actionSheet, animated: true, completion: nil)
            
        }
        
       //}
        
    }
    
    func checkingCameraAuthStatus() -> Bool {
        var status = false
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            print("authorized camera")
            status = true
        case .denied:
            let alert = UIAlertController(title: "Нет доступа к камере", message: nil, preferredStyle: .alert)
            status = false
            let cancel = UIAlertAction(title: "Ок", style: .cancel)
            alert.addAction(cancel)
//            DispatchQueue.main.async {
                self.present(alert, animated: true)
//            }
        case .restricted:
            status = false
            let alert = UIAlertController(title: "Ограничен доступ к  камере", message: nil, preferredStyle: .alert)
            let cancel = UIAlertAction(title: "Ок", style: .cancel)
            alert.addAction(cancel)
            DispatchQueue.main.async {
                self.present(alert, animated: true)
            }
            
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
                if granted {
                    status = true
                    if UIImagePickerController.isSourceTypeAvailable(.camera) {
                        DispatchQueue.main.async {
                            self.imagePicker.sourceType = .camera
                            self.imagePicker.allowsEditing = true
                            self.imagePicker.showsCameraControls = true
                            self.imagePicker.delegate = self
                            self.present(self.imagePicker, animated: true, completion: nil)
                        }
                        
                    }
                } else {
                    status = false
                }
            })
        }
        return status

    }
    
    func checkingAuthStatusPhotoLibrary() -> Bool {
        var statusL = false
        let photoAuthorizationStatus =  PHPhotoLibrary.authorizationStatus()
        switch photoAuthorizationStatus {
        case .authorized:
            print("authorized library")
            statusL = true
            //pickImageControllerConfigure()
        case .denied:
            let alert = UIAlertController(title: "Нет доступа к галерее", message: nil, preferredStyle: .alert)
            statusL = false
            let cancel = UIAlertAction(title: "Ок", style: .cancel)
            alert.addAction(cancel)
//            DispatchQueue.main.async {
                self.present(alert, animated: true)
//            }
        case .restricted:
            statusL = false
            let alert = UIAlertController(title: "Ограничен доступ к галерее", message: nil, preferredStyle: .alert)
            let cancel = UIAlertAction(title: "Ок", style: .cancel)
            alert.addAction(cancel)
            DispatchQueue.main.async {
                self.present(alert, animated: true)
            }
            
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { (status) in
                    if status == .authorized {
                        DispatchQueue.main.async {
                            self.imagePicker.sourceType = .photoLibrary
                            self.imagePicker.allowsEditing = true
                            self.imagePicker.delegate = self
                            self.present(self.imagePicker, animated: true, completion: nil)
                            statusL = true
                        }
                        
                    }
            }
        }
        return statusL
    }
    
    @IBAction func pickImageTapped(_ sender: UIButton) {
        view.endEditing(true)
        pickImageControllerConfigure()
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
        } else {
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
                imageNew.image = image
            }
        }
        self.dismiss(animated: true, completion: nil)
    }
}
