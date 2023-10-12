//
//  Collection.swift
//  cell1
//
//  Created by admin on 03.10.2023.
//

import Foundation
import UIKit

class CollectionViewController : UIViewController  {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var dataManager = DataManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataManager.loadImagesFromJSON()
        collectionView.reloadData()
        let customFlowLayout = UICollectionViewFlowLayout()
            customFlowLayout.minimumInteritemSpacing = 0
            customFlowLayout.minimumLineSpacing = 0
            customFlowLayout.itemSize = CGSize(width: collectionView.frame.width / 3, height: collectionView.frame.width / 3)
            customFlowLayout.sectionInset = UIEdgeInsets.zero
            collectionView.collectionViewLayout = customFlowLayout
       
    }
}

extension CollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        21
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionCell", for: indexPath) as! ImageCollectionViewCell
        
        if let url = URL(string: dataManager.arreysImages[indexPath.row]){
            cell.loadImage(url: url)
        }
        return cell
    }
}

extension CollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let imageURL = URL(string: dataManager.arreysImages[indexPath.row]) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "ImageViewerViewController") as! ImageViewerViewController
            viewController.setup(withUrl: imageURL)
            self.present(viewController, animated: true)
            
            
        }
    }
}
