//
//  LoginViewController.swift
//  Dyal
//
//  Created by Арман on 5/1/18.
//  Copyright © 2018 Арман. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginBoxBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var rightLoginBoxConstraint: NSLayoutConstraint!
    @IBOutlet weak var leftLoginBoxConstraint: NSLayoutConstraint!
    @IBOutlet weak var registrationButton: UIButton!
    var constraintloginBoxBottomHolder: CGFloat = 0.0
    var constraintRegButtonBottomHolder: CGFloat = 0.0
    @IBOutlet weak var bottomRegistrationLostPasswordConstraint: NSLayoutConstraint!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginBox: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        loginBoxSetup()
        loginButtonSetup()
        textFieldsSetup()
        configureTapGesture()
        addNotificationObserevers()
        configureConstraints()
    }
    
    func configureConstraints() {
        loginBoxBottomConstraint.constant = view.frame.height / 2.3
        loginBox.translatesAutoresizingMaskIntoConstraints = false
        if UIDevice.IsPortrait {
            leftLoginBoxConstraint.constant = (view.frame.width - (view.frame.width * 0.85)) / 2
            rightLoginBoxConstraint.constant = (view.frame.width - (view.frame.width * 0.85)) / 2
        } else {
            leftLoginBoxConstraint.constant = (view.frame.width - (view.frame.width * 0.5)) / 2
            rightLoginBoxConstraint.constant = (view.frame.width - (view.frame.width * 0.5)) / 2
        }
        
        constraintloginBoxBottomHolder = loginBoxBottomConstraint.constant
        constraintRegButtonBottomHolder = bottomRegistrationLostPasswordConstraint.constant
    }
    func addNotificationObserevers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification: )), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        loginBoxBottomConstraint.constant = size.height / 2.3
        constraintloginBoxBottomHolder = loginBoxBottomConstraint.constant
        if UIDevice.IsPortrait {
            leftLoginBoxConstraint.constant = (size.width - (size.width * 0.85)) / 2
            rightLoginBoxConstraint.constant = (size.width - (size.width * 0.85)) / 2
        } else {
            leftLoginBoxConstraint.constant = (size.width - (size.width * 0.5)) / 2
            rightLoginBoxConstraint.constant = (size.width - (size.width * 0.5)) / 2
        }
    }
    
    @IBAction func unwindTo(sender: UIStoryboardSegue) {}
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let info = notification.userInfo {
            let keyboardRect: CGRect = info["UIKeyboardFrameEndUserInfoKey"] as! CGRect
            if keyboardRect.height > 0 {
                let difference = loginBoxBottomConstraint.constant - (keyboardRect.height + registrationButton.frame.height + 25)
                if difference < 0 {
                    self.loginBoxBottomConstraint.constant = self.constraintloginBoxBottomHolder + abs(difference)
                }
                self.bottomRegistrationLostPasswordConstraint.constant = keyboardRect.height + 10
                UIView.animate(withDuration: 0.4, delay: 0.1, usingSpringWithDamping: 0.8, initialSpringVelocity: 2, options: .curveEaseOut, animations: {
                    self.view.layoutIfNeeded()
                }, completion: nil)
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.bottomRegistrationLostPasswordConstraint.constant = self.constraintRegButtonBottomHolder
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 2, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        self.loginBoxBottomConstraint.constant = self.constraintloginBoxBottomHolder
        UIView.animate(withDuration: 1){
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
    
    func loginButtonSetup(){
        loginButton.backgroundColor = UIColor(red:0.00, green:0.48, blue:1.00, alpha:1.0)
        //loginButton.createGradientLayer(withRoundedCorners: false)
        loginButton.layer.cornerRadius = 7
        loginButton.layer.masksToBounds = true
    }
    func textFieldsSetup(){
        loginTextField.delegate = self
        passwordTextField.delegate = self
    }
    func loginBoxSetup(){
        loginBox.layer.cornerRadius = 10
        loginBox.layer.masksToBounds = true
        loginBox.layer.shadowColor = UIColor.black.cgColor
        loginBox.layer.shadowOffset = CGSize(width: 0, height: 10)
        loginBox.layer.shadowOpacity = 0.1
        loginBox.layer.shadowRadius = 3.0
        loginBox.layer.masksToBounds = false
        loginBox.layer.backgroundColor = UIColor.white.cgColor
    }
    @IBAction func loginTapped(_ sender: Any) {
        view.endEditing(true)
    }
    
    
    @IBAction func registrationTapped(_ sender: Any) {
        view.endEditing(true)
    }

}
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
