//
//  ScatUploadSuccessViewController.swift
//  Scatt Koala
//
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
