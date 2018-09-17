//
//  DetailsViewController.swift
//  Dyal
//
//  Created by Арман on 9/17/18.
//  Copyright © 2018 Арман. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    
    @IBOutlet weak var textView: UIView!
    var name: String!
    
    var imageName: String!
    
    @IBOutlet private weak var detailsLabel: UILabel!
    @IBOutlet private weak var detailsImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        textView.layer.borderWidth = 0.5
        textView.layer.masksToBounds = true
        textView.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        detailsLabel.text = name
        detailsImage.image = UIImage(named: imageName)
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
