//
//  json.swift
//  cell1
//
//  Created by admin on 27.09.2023.
//

import Foundation

class ImageData: Codable {
    
    let imagesUrl: [String]
}
class DataManager {
    
    var arreysImages: [String] = []

    func loadImagesFromJSON() {
        if let url = Bundle.main.url(forResource: "links", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let imageData = try decoder.decode(ImageData.self, from: data)

                arreysImages = imageData.imagesUrl
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
