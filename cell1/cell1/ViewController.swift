//
//  ViewController.swift
//  cell1
//
//  Created by admin on 26.09.2023.
//

import UIKit

class ViewController: UIViewController  {
    
    @IBOutlet weak var tableView: UITableView! 
    
    var dataManager = DataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataManager.loadImagesFromJSON()
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataManager.arreysImages.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellImage", for: indexPath) as? ImageTableViewCell
        cell?.dataTask?.cancel()
        if let url = URL(string: dataManager.arreysImages[indexPath.row]) {
            cell?.loadImage(url: url)
        }
        
        return cell!
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let imageURL = URL(string: dataManager.arreysImages[indexPath.row]) {
           let storyboard = UIStoryboard(name: "Main", bundle: nil)
           let viewController = storyboard.instantiateViewController(withIdentifier: "ImageViewerViewController") as! ImageViewerViewController
            viewController.setup(withUrl: imageURL)
            
            self.present(viewController, animated: true)
        }
    }
}
