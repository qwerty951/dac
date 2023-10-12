//
//  ImageTableViewCell.swift
//  cell1
//
//  Created by admin on 26.09.2023.
//

import Foundation
import UIKit

class ImageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageCell: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var sizeLabel: UILabel!
    
    var dataTask: URLSessionDataTask?
    let imageCache = NSCache<NSString, UIImage>()
    
    func loadImage(url: URL) {
        nameLabel.text = nil
        sizeLabel.text = nil
        imageCell.layer.cornerRadius = 75
        imageCell?.image = nil
        dataTask?.cancel()
        
        dataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let data = data, let image = UIImage(data: data) else {
                print("Failed to load image from URL: \(url)")
                return
            }
            DispatchQueue.main.async {
                self?.imageCell?.image = image
            }
            if let imageName = url.lastPathComponent.removingPercentEncoding {
                DispatchQueue.main.async {
                    self?.nameLabel.text = imageName
                }
            }
            let imageSizeInBytes = data.count
            let imageSizeInKB = Double(imageSizeInBytes) / 1024.0
          //  let imageSizeInMB = imageSizeInKB / 1024.0
            
            DispatchQueue.main.async {
                self?.sizeLabel.text = String(format: "%.2f KB", imageSizeInKB)
            }
            self?.imageCache.setObject(image, forKey: url.absoluteString as NSString)
        }
        
        dataTask?.resume()
    }
}
