//
//  cellCollection.swift
//  cell1
//
//  Created by admin on 03.10.2023.
//

import Foundation
import UIKit

class ImageCollectionViewCell : UICollectionViewCell {
    
    @IBOutlet weak var imageCollection: UIImageView! 
    
    @IBOutlet weak var backolorLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    
    var imageURL: URL?
    
    func loadImage(url: URL) {
        imageCollection.image = nil
        
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileName = url.lastPathComponent
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        
        if FileManager.default.fileExists(atPath: fileURL.path) {
            if let imageData = try? Data(contentsOf: fileURL), let image = UIImage(data: imageData) {
                displayImageInfo(image: image, url: url)
                imageCollection.image = image
            } else {
                print("Failed to load image from file.")
            }
        } else {
            imageURL = url
            URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
                guard let self = self else { return }
                
                guard let data = data, let image = UIImage(data: data) else {
                    DispatchQueue.main.async {
                        self.displayImageInfo(image: nil, url: url)
                    }
                    return
                }
                
                if let imageData = image.jpegData(compressionQuality: 1.0) {
                    do {
                        try imageData.write(to: fileURL)
                        print("Image successfully saved to file: \(fileURL)")
                    } catch {
                        print("Error saving image to file: \(error)")
                    }
                }
                
                if self.imageURL == url {
                    DispatchQueue.main.async {
                        self.imageCollection.image = image
                        self.displayImageInfo(image: image, url: url)
                    }
                }
            }.resume()
        }
    }
    
    func displayImageInfo(image: UIImage?, url: URL) {
        if let image = image {
            
            if let imageData = image.pngData() {
                let imageSize = Double(imageData.count) / 1024
                
                DispatchQueue.main.async {
                    self.nameLabel.text = url.lastPathComponent
                    self.sizeLabel.text = String(format: "%.2f KB", imageSize)
                }
            }
        } else {
            print("Failed to load image from file or network")
        }
    }
}

