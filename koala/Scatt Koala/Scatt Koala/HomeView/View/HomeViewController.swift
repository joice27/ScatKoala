//
//  HomeViewController.swift
//  Koala Scat Collection
//
//  Created by Joice George on 02/09/23.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var koalaGallaryCollection: UICollectionView!
    @IBOutlet weak var gallaryPageControl: UIPageControl!
    let imageArray: [String] = ["koala1", "koala2", "koala3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        koalaGallaryCollection.register(UINib(nibName: "KoalaGallaryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "koalaGallaryCell")
        koalaGallaryCollection.dataSource = self
        koalaGallaryCollection.delegate = self
        
        UserDefaults.standard.setValue(true, forKey: "loggedIn")
        
        self.navigationItem.hidesBackButton = true
    }
    
    
    @IBAction func uploadKoalaSightClicked(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "addKoalaSighting") as! UploadKoalaSightViewController
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func uploadScattClicked(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "addScatCollection") as! UplaodScattDetailsViewController
        self.navigationController?.pushViewController(vc, animated: false)

    }
    
    @IBAction func logoutButtonClicked(_ sender: Any) {
        let alert = UIAlertController(title: "Logout", message: "Are you sure want to Logout!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: {_ in
            
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "firstView") as! SignInViewController
            self.navigationController?.pushViewController(vc, animated: false)
            UserDefaults.standard.setValue(false, forKey: "loggedIn")
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        self.present(alert, animated: false)
    }
    
    @IBAction func infoButtonClicked(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "infoView") as! InfoViewController
        self.navigationController?.pushViewController(vc, animated: false)
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "koalaGallaryCell", for: indexPath) as! KoalaGallaryCollectionViewCell
        cell.koalaImageView.image = UIImage(named: (self.imageArray[indexPath.row]))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: koalaGallaryCollection.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        gallaryPageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }

    
}
