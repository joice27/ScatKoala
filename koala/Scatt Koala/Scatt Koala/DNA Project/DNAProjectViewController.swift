//
//  DNAProjectViewController.swift
//  Scatt Koala
//
//

import UIKit

class DNAProjectViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickHereButtonClick(_ sender: Any) {
        
        guard let url = URL(string: "https://www.ari.vic.gov.au/research/threatened-plants-and-animals/the-great-victorian-koala-survey") else {return}
        UIApplication.shared.open(url)
        
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
