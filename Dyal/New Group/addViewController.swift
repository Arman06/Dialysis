//
//  addViewController.swift
//  Dyal
//
//  Created by Арман on 9/24/18.
//  Copyright © 2018 Арман. All rights reserved.
//

import UIKit

class addViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var outerStackView: UIStackView!
    @IBOutlet weak var topStackViewConstraint: NSLayoutConstraint!
    var topStackViewConstraintConstantHolder: CGFloat = 0.0
    
    
    @IBOutlet weak var potassiumTextField: UITextField!
    @IBOutlet weak var sodiumTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var imageContainer: UIView!
    
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var pickImageButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldsSetup()
        configureTapGesture()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification: )), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        topStackViewConstraint.constant = view.frame.height / 15
        
        topStackViewConstraintConstantHolder = topStackViewConstraint.constant
        if let image = imageContainer.viewWithTag(110) as? UIImageView {
            image.image = UIImage(named: DataService.instance.getFood()[0].imageName)
            image.layer.cornerRadius = 13
            image.layer.masksToBounds = true
        }
        imageContainer.layer.cornerRadius = 13
        imageContainer.layer.masksToBounds = true
    }

    
    func textFieldsSetup(){
        nameTextField.delegate = self
        sodiumTextField.delegate = self
        potassiumTextField.delegate = self
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let info = notification.userInfo {
            let keyboardRect: CGRect = info["UIKeyboardFrameEndUserInfoKey"] as! CGRect
            if keyboardRect.height > 0 {
                self.view.layoutIfNeeded()
                let difference = self.view.frame.height - (self.topStackViewConstraintConstantHolder + self.outerStackView.frame.height + keyboardRect.height + 15)
//                print("\(self.view.frame.height) - \(self.topStackViewConstraintConstantHolder + self.outerStackView.frame.height + keyboardRect.height) = \(difference)")
                UIView.animate(withDuration: 0.3){
                    if difference < 0 {
                    self.topStackViewConstraint.constant = self.topStackViewConstraintConstantHolder - abs(difference)
                    }
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 3){
            self.topStackViewConstraint.constant = self.topStackViewConstraintConstantHolder
            //self.bottomRegistrationConstraints.constant = self.constraintRegButtonBottomHolder
            self.view.layoutIfNeeded()
            
        }
    }
    func configureTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    
    
    
    
    @IBAction func pickImageTapped(_ sender: UIButton) {
        view.endEditing(true)
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

extension addViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
