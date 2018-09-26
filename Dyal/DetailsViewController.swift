//
//  DetailsViewController.swift
//  Dyal
//
//  Created by Арман on 9/17/18.
//  Copyright © 2018 Арман. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var textView: UITextView!
    var name: String!
    
    var imageName: String!
    
    var potassium: Float!
    
    @IBOutlet weak var descriptionText: UITextView!
    var sodium: Float!
    
    @IBOutlet private weak var detailsLabel: UILabel!
    @IBOutlet private weak var detailsImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = "  Натрий: \(String(sodium)) mg\n  Калий: \(String(potassium)) mg"
        detailsLabel.text = name
        detailsImage.image = UIImage(named: imageName)
        detailsImage.layer.cornerRadius = 13
        detailsImage.layer.masksToBounds = true
        configureButton(for: backButton, withRadius: 15)
    }
    
    func configureButton(for button: UIButton, withRadius radius: CGFloat) {
        button.backgroundColor = UIColor(red:0.00, green:0.48, blue:1.00, alpha:1.0)
        button.layer.cornerRadius = radius
        button.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        button.layer.shadowOffset = CGSize(width: 2, height: 5)
        button.layer.shadowOpacity = 0.2
        button.layer.shadowRadius = 4.0
        button.layer.masksToBounds = false
        button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
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
