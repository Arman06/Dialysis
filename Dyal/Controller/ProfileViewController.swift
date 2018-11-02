//
//  ProfileViewController.swift
//  Dyal
//
//  Created by Арман on 11/2/18.
//  Copyright © 2018 Арман. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {

    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var exitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Auth.auth().currentUser?.displayName)
        emailLabel.text = Auth.auth().currentUser?.email
        nameLabel.text = Auth.auth().currentUser?.displayName
        // Do any additional setup after loading the view.
    }
    
    @IBAction func exitButtonTapped(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
            performSegue(withIdentifier: "LogInFromProfile", sender: self)
        } catch {
            print(error)
        }
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
