//
//  ScatUploadSuccessViewController.swift
//  Scatt Koala
//
//  Created by Joice George on 05/10/23.
//

import UIKit

class ScatUploadSuccessViewController: UIViewController {
    
    var uploadId: String = ""

    @IBOutlet weak var responseIdLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        responseIdLabel.text = "Please label your sample with the following code \(String(describing: uploadId))"
    }
}
