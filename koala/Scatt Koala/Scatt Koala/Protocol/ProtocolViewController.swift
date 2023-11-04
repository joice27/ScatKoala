//
//  ProtocolViewController.swift
//  Scatt Koala
//
//

import UIKit

class ProtocolViewController: UIViewController {
    @IBOutlet weak var protocolTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        protocolTable.register(UINib(nibName: "ProtocolTableViewCell", bundle: nil), forCellReuseIdentifier: "instructionCell")
        protocolTable.dataSource = self
        protocolTable.delegate = self
        
        protocolTable.rowHeight = UITableView.automaticDimension

    }
}

extension ProtocolViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "instructionCell", for: indexPath) as! ProtocolTableViewCell
        if indexPath.row == 0 {
            cell.titleLabel.text = SIGHT_KOLA_TITLE
            cell.descriptionLabel.text = SIGHT_KOALA
            cell.instructionImageView.image = UIImage(named: "first")
        } else if indexPath.row == 1 {
            cell.titleLabel.text = FRESH_SCAT_TITLE
            cell.descriptionLabel.text = FRESH_SCAT
            cell.instructionImageView.image = UIImage(named: "second")
        } else if indexPath.row == 2 {
            cell.titleLabel.text = THIRD_TITLE
            cell.descriptionLabel.text = THIRD
            cell.instructionImageView.image = UIImage(named: "third")
        } else if indexPath.row == 3 {
            cell.titleLabel.text = FOURTH_TITLE
            cell.descriptionLabel.text = FOURTH
            cell.instructionImageView.image = UIImage(named: "fourth")
        } else  {
            cell.titleLabel.text = FIFTH_TITLE
            cell.descriptionLabel.text = FIFTH
            cell.instructionImageView.image = UIImage(named: "fifth")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
