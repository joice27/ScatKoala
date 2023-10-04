//
//  InfoViewController.swift
//  Scatt Koala
//
//  Created by Joice George on 05/10/23.
//

import UIKit

class InfoViewController: UIViewController {
    
    @IBOutlet weak var gallaryPageController: UIPageControl!
    @IBOutlet weak var kolaGallaryCollection: UICollectionView!
    let imageArray: [String] = ["koala1", "koala2", "koala3"]

    
    override func viewDidLoad() {
        super.viewDidLoad()

        kolaGallaryCollection.register(UINib(nibName: "KoalaGallaryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "koalaGallaryCell")
        kolaGallaryCollection.dataSource = self
        kolaGallaryCollection.delegate = self
        
    }

}

extension InfoViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "koalaGallaryCell", for: indexPath) as! KoalaGallaryCollectionViewCell
        cell.koalaImageView.image = UIImage(named: (self.imageArray[indexPath.row]))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: kolaGallaryCollection.frame.width, height: kolaGallaryCollection.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        gallaryPageController.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }

    
    
}
