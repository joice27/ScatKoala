//
//  HomeViewController.swift
//  Koala Scat Collection
//
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var koalaGallaryCollection: UICollectionView!
    @IBOutlet weak var gallaryPageControl: UIPageControl!
    let imageArray: [String] = ["koala1", "koala2", "koala3"]
    let locationManager = LocationManager.shared
    let viewModel: HomeViewModel = HomeViewModel()
    
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
            self.navigateToSignInView()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        self.present(alert, animated: false)
    }
    
    @IBAction func protocolButtonClicked(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "protocolView") as! ProtocolViewController
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func mailingAddressButtonClicked(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mailingAddress") as! MailingAddressViewController
        self.navigationController?.pushViewController(vc, animated: false)

    }
    
    @IBAction func collectionMaterialButtonClicked(_ sender: Any) {
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "collectionMaterial") as! CollectionMaterialViewController
        self.navigationController?.pushViewController(vc, animated: false)

    }
    
    @IBAction func dnaProjectClicked(_ sender: Any) {
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "dnaView") as! DNAProjectViewController
        self.navigationController?.pushViewController(vc, animated: false)

    }
    
    @IBAction func deleteAccoutClicked(_ sender: Any) {
        let alert = UIAlertController(title: "Delete Account", message: "Are you sure you want to delete your account?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "YES", style: .default, handler: {_ in
            self.deleteAccount()
        }))
        alert.addAction(UIAlertAction(title: "NO", style: .cancel))
        self.present(alert, animated: false)
    }
    
    func navigateToSignInView() {
        DispatchQueue.main.async {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "firstView") as! SignInViewController
            self.navigationController?.pushViewController(vc, animated: false)
            UserDefaults.standard.setValue(false, forKey: "loggedIn")
        }
    }
    
    func deleteAccount() {
        self.showActivityIndicator()
        self.viewModel.deleteAccount(onCompletion: { status in
            self.hideActivityIndicator()
            if status {
                self.navigateToSignInView()
            } else {
                let alert = UIAlertController(title: "Error", message: "Unable to delete the account", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                DispatchQueue.main.async {
                    self.present(alert, animated: false)
                }
            }
        })
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
