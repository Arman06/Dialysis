//
//  LoginViewController.swift
//  Dyal
//
//  Created by Арман on 5/1/18.
//  Copyright © 2018 Арман. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginBox: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        loginBoxSetup()
        loginButtonSetup()
        textFieldsSetup()
        
       
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loginButtonSetup(){
        loginButton.backgroundColor = UIColor(red:0.00, green:0.48, blue:1.00, alpha:1.0)
        loginButton.layer.cornerRadius = 10
    }
    func textFieldsSetup(){
        loginTextField.borderStyle = .none
        loginTextField.layer.cornerRadius = 10
        loginTextField.layer.masksToBounds = true
        passwordTextField.borderStyle = .none
        passwordTextField.layer.masksToBounds = true
        passwordTextField.layer.cornerRadius = 10
        loginTextField.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.90, alpha:1.0)
        passwordTextField.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.90, alpha:1.0)
    }
    func loginBoxSetup(){
        loginBox.layer.cornerRadius = 10
        loginBox.layer.masksToBounds = true
        loginBox.layer.shadowColor = UIColor.black.cgColor
        loginBox.layer.shadowOffset = CGSize(width: 2, height: 15)
        loginBox.layer.shadowOpacity = 0.1
        loginBox.layer.shadowRadius = 4.0
        loginBox.layer.masksToBounds = false
        loginBox.layer.backgroundColor = UIColor.white.cgColor
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
