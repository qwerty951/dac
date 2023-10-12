//
//  Shared Object.swift
//  cell1
//
//  Created by admin on 11.10.2023.
//

import Foundation
import UIKit

class ImageStorage {
    
    static let shared = ImageStorage()
    private let imageDirectory: FileManager.SearchPathDirectory = .documentDirectory
    var imageURL: URL?
    private init() { }
    
    func loadAllImages() -> [UIImage] {
            let fileManager = FileManager.default
            guard let documentDirectoryURL = fileManager.urls(for: imageDirectory, in: .userDomainMask).first else {
                return []
            }
            
            do {
                let fileURLs = try fileManager.contentsOfDirectory(at: documentDirectoryURL, includingPropertiesForKeys: nil, options: [])
                var images: [UIImage] = []
                
                for fileURL in fileURLs {
                    if let data = try? Data(contentsOf: fileURL), let image = UIImage(data: data) {
                        images.append(image)
                    }
                }
                
                return images
            } catch {
                print("Error reading directory: \(error)")
                return []
            }
        }
    }
