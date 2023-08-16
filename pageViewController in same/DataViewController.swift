//
//  DataViewController.swift
//  pageViewController in same
//
//  Created by Digival on 14/08/23.
//

import UIKit

class DataViewController: UIViewController {
var index = 0
    @IBOutlet weak var dataLabel: UILabel!
    var labelText: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        dataLabel.text = labelText
        view.backgroundColor = .red
        view.roundCorners([.topRight,.bottomRight], radius: 25)
  
    }

    }

    // Use it like this
  


