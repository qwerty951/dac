//
//  ScrollviewController .swift
//  cell1
//
//  Created by admin on 11.10.2023.
//

import Foundation
import UIKit

class ScrollViewController : UIViewController, UIScrollViewDelegate {
    
    var scrollView = UIScrollView()
    var imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.delegate = self
        
        scrollView.maximumZoomScale = 2
        scrollView.minimumZoomScale = 0.5
        
        view.addSubview(scrollView)
        
        let HorScrollView = NSLayoutConstraint(item: scrollView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 5)
        let HorScrollViewTrailing = NSLayoutConstraint(item: scrollView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: -5)
        let VerScrollView = NSLayoutConstraint(item: scrollView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 5)
        let VerScrollViewBottom = NSLayoutConstraint(item: scrollView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: -5)
        
        NSLayoutConstraint.activate([HorScrollView, HorScrollViewTrailing, VerScrollView, VerScrollViewBottom])
        
        let images = ImageStorage.shared.loadAllImages()
        
        var previousImageView: UIImageView?
        
        for image in images {
            let imageSubview = UIImageView(image: image)
            scrollView.addSubview(imageSubview)
            imageSubview.translatesAutoresizingMaskIntoConstraints = false
            imageSubview.contentMode = .scaleAspectFill
            
            let leadingConstraint = NSLayoutConstraint(item: imageSubview, attribute: .leading, relatedBy: .equal, toItem: scrollView, attribute: .leading, multiplier: 1.0, constant: 5)
            let trailingConstraint = NSLayoutConstraint(item: imageSubview, attribute: .trailing, relatedBy: .equal, toItem: scrollView, attribute: .trailing, multiplier: 1.0, constant: -5)
            
            leadingConstraint.isActive = true
            trailingConstraint.isActive = true
            
            let views = ["image": imageSubview]
            
            let HorImageView = NSLayoutConstraint(item: imageSubview, attribute: .width, relatedBy: .equal, toItem: scrollView, attribute: .width, multiplier: 1.0, constant: -5)
            
            let VerImageView: [NSLayoutConstraint]
            
            if let previousImageView = previousImageView {
                VerImageView = NSLayoutConstraint.constraints(withVisualFormat: "V:[previousImage]-10-[image]", metrics: nil, views: ["previousImage": previousImageView, "image": imageSubview])
            } else {
                VerImageView = NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[image]", metrics: nil, views: views)
            }
            scrollView.contentSize = CGSize(width: scrollView.frame.size.width, height: scrollView.frame.size.height * CGFloat(images.count))
            NSLayoutConstraint.activate([HorImageView] + VerImageView)
            
            previousImageView = imageSubview
            
            scrollView.contentSize = CGSize(width: scrollView.contentSize.width, height: scrollView.contentSize.height + imageSubview.bounds.size.height + 10)
        }
        
        if let lastImageView = previousImageView {
            let VerScrollViewBottom = NSLayoutConstraint.constraints(withVisualFormat: "V:[lastImage]-10-|", metrics: nil, views: ["lastImage": lastImageView])
            NSLayoutConstraint.activate(VerScrollViewBottom)
        }
    }
}
