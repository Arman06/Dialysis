//
//  RegistrationViewController.swift
//  Dyal
//
//  Created by Арман on 10/13/18.
//  Copyright © 2018 Арман. All rights reserved.
//

import UIKit

import Firebase

class RegistrationViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    var name = String()
    
    var email = String()
    
    var password = String()
    
    var nextButtonAfterConstraint: CGFloat = 0.0
    
    @IBOutlet weak var nextButtonBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var nextButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTapGesture()
        emailTextField.delegate = self
        nameTextField.delegate = self
        passwordTextField.delegate = self
        nextButtonAfterConstraint = nextButtonBottomConstraint.constant
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification: )), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        // Do any additional setup after loading the view.
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let info = notification.userInfo {
            let keyboardRect: CGRect = info["UIKeyboardFrameEndUserInfoKey"] as! CGRect
            self.view.layoutIfNeeded()
            UIView.animate(withDuration: 0.3, animations:{
                self.nextButtonBottomConstraint.constant = keyboardRect.height + 20
                self.view.layoutIfNeeded()
            })
        }
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 4, animations:{
            self.nextButtonBottomConstraint.constant = self.nextButtonAfterConstraint
            self.view.layoutIfNeeded()
        })
    }
    
    
    
    func configureTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == nameTextField {
            name = textField.text ?? ""
        }
        if textField == emailTextField {
            email = textField.text ?? ""
        }
        
        if textField == passwordTextField {
            password = textField.text ?? ""
        }
        
    }
    
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        view.endEditing(true)
        if email != "", name != "", password != "" {
            Auth.auth().createUser(withEmail: email, password: password) {
                (user, error) in
                if error != nil {
                    if let errorCode = AuthErrorCode(rawValue: error!._code) {
                        switch errorCode {
                        case .weakPassword:
                            let alert = UIAlertController(title: "Легкий пароль", message: nil, preferredStyle: .alert)
                            let action = UIAlertAction(title: "Окей", style: .cancel, handler: nil)
                            alert.addAction(action)
                            self.present(alert, animated: true)
                        default:
                            print("There is an error")
                        }
                    }
                }
                if user != nil, user?.user.isEmailVerified == false {
                    user?.user.sendEmailVerification{ (error) in
                        print(error?.localizedDescription ?? "none")
                        let alert = UIAlertController(title: "Ошибка", message: nil, preferredStyle: .alert)
                        let action = UIAlertAction(title: "Окей", style: .cancel, handler: nil)
                        alert.addAction(action)
                        self.present(alert, animated: true)
                    }
                    Auth.auth().signIn(withEmail: self.email, password: self.password)
                    let changeRequest = user?.user.createProfileChangeRequest()
                    changeRequest?.displayName = self.name
                    changeRequest?.commitChanges(completion: { (error) in
                        guard error == nil else {
                            let alert = UIAlertController(title: "Ошибка", message: nil, preferredStyle: .alert)
                            let action = UIAlertAction(title: "Окей", style: .cancel, handler: nil)
                            alert.addAction(action)
                            self.present(alert, animated: true)
                            return
                        }
                    })
                    self.performSegue(withIdentifier: "LogInFromRegistration", sender: nil)
                    
                }
            }
        } else {
            let alert = UIAlertController(title: "Ошибка", message: "Проверьте поля регистрации", preferredStyle: .alert)
            let action = UIAlertAction(title: "Окей", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true)
        }

        
        
    }
    
}
