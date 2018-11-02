//
//  ResetPasswordViewController.swift
//  Dyal
//
//  Created by Арман on 11/2/18.
//  Copyright © 2018 Арман. All rights reserved.
//

import UIKit
import Firebase

class ResetPasswordViewController: UIViewController, UITextFieldDelegate {

    var email = String()
    var password = String()
    
    var changeButtonConstraintConstant: CGFloat = 0.0
    
    @IBOutlet weak var changeButtonConstraint: NSLayoutConstraint!
    @IBOutlet weak var emailField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTapGesture()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification: )), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        changeButtonConstraintConstant = changeButtonConstraint.constant
        emailField.delegate = self
        // Do any additional setup after loading the view.
    }
    

    @objc func keyboardWillShow(notification: NSNotification) {
        if let info = notification.userInfo {
            let keyboardRect: CGRect = info["UIKeyboardFrameEndUserInfoKey"] as! CGRect
            self.view.layoutIfNeeded()
            UIView.animate(withDuration: 0.3, animations:{
                self.changeButtonConstraint.constant = keyboardRect.height + 20
                self.view.layoutIfNeeded()
            })
        }
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 4, animations:{
            self.changeButtonConstraint.constant = self.changeButtonConstraintConstant
            self.view.layoutIfNeeded()
        })
    }
    
    @IBAction func changeButtonPressed(_ sender: UIButton) {
        view.endEditing(true)
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if error != nil {
                let alert = UIAlertController(title: "Ошибка", message: "Проверьте поле Эл. адрес", preferredStyle: .alert)
                let action = UIAlertAction(title: "Окей", style: .cancel, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true)
            } else {
                let alert = UIAlertController(title: "Инструкции отправлены", message: "Проверьте свою почту", preferredStyle: .alert)
                let action = UIAlertAction(title: "Окей", style: .cancel, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true)
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == emailField {
            email = textField.text ?? ""
        }
        
    }
    
    func configureTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
