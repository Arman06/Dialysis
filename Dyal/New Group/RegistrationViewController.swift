//
//  RegistrationViewController.swift
//  Dyal
//
//  Created by Арман on 10/13/18.
//  Copyright © 2018 Арман. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {

    var nextButtonAfterConstraint: CGFloat = 0.0
    
    @IBOutlet weak var nextButtonBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var nextButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTapGesture()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification: )), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        // Do any additional setup after loading the view.
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let info = notification.userInfo {
            let keyboardRect: CGRect = info["UIKeyboardFrameEndUserInfoKey"] as! CGRect
            self.view.layoutIfNeeded()
            UIView.animate(withDuration: 1.5, animations:{
                self.view.layoutIfNeeded()
                self.nextButtonBottomConstraint.constant = keyboardRect.height + 20
            })
        }
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 1.5, animations:{
            self.view.layoutIfNeeded()
            self.nextButtonBottomConstraint.constant = 20
        })
    }
    
    
    
    func configureTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    
}
