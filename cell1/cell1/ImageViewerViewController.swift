//
//  ImageViewer.swift
//  cell1
//
//  Created by admin on 04.10.2023.
//

import Foundation
import UIKit

class ImageViewerViewController : UIViewController {
    
    @IBOutlet weak var imageViewer: UIImageView?
    
    @IBOutlet weak var dateLabel: UILabel?
    
    var imageURL: URL?
    
    override func viewDidLoad() {
           super.viewDidLoad()
           if let url = imageURL {
               setup(withUrl: url)
           }
       }
       
       @IBAction func closeButton(_ sender: Any) {
           dismiss(animated: true)
       }
       
       init?(coder: NSCoder, imageURL: URL) {
           super.init(coder: coder)
       }
       
       required init?(coder: NSCoder) {
           super.init(coder: coder)
       }
       
    func setup(withUrl url: URL) {
        let fileManager = FileManager.default
        guard let documentDirectoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return
        }
        self.imageURL = url
        
        let imageFileURL = documentDirectoryURL
            .appendingPathComponent(url.lastPathComponent)
        if let image = loadImageFromFile(url: imageFileURL) {
            imageViewer?.image = image
        } else {
            print("imageViewer is nil")
        }
        
        do {
            let attrs = try FileManager.default.attributesOfItem(atPath: imageFileURL.path)
            
            if let creationDate = attrs[.creationDate] as? Date {
                let dateFormmater = DateFormatter()
                dateFormmater.dateFormat = "yyyy-MM-dd"
                dateLabel?.text = "Date: \(dateFormmater.string(from: creationDate))"
            } else {
                print("File creation date not found.")
            }
        } catch {
            print("Error getting file attributes: \(error)")
        }
    }
    func loadImageFromFile(url: URL) -> UIImage? {
        if let imageData = try? Data(contentsOf: url), let image = UIImage(data: imageData) {
            return image
        }
        return nil
    }
    
    func loadDateFromFile(url: URL) -> String? {
        do {
            let date = try String(contentsOf: url, encoding: .utf8)
            return date
        } catch {
            print("Error loading date from file: \(error)")
            return nil
        }
    }
}




