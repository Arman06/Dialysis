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
    
    var image: UIImage?
    
    var potassium: Float!
    
    @IBOutlet weak var descriptionText: UITextView!
    var sodium: Float!
    
    @IBOutlet private weak var detailsLabel: UILabel!
    @IBOutlet private weak var detailsImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = "  Натрий: \(String(sodium)) mg\n  Калий: \(String(potassium)) mg"
        detailsLabel.text = name
        detailsImage.image = image
        detailsImage.layer.cornerRadius = 13
        detailsImage.layer.masksToBounds = true
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
