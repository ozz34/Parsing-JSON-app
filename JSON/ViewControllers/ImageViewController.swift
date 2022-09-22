//
//  ImageViewController.swift
//  JSON
//
//  Created by Иван Худяков on 19.09.2022.
//

import UIKit

final class ImageViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
        fetchImage()
    }
    
    private func fetchImage() {
        
        NetworkManager.shared.fetchImage(from: Link.imageURL.rawValue) { imageData in
            self.imageView.image = UIImage(data: imageData)
            self.activityIndicator.stopAnimating()
        }
    }
}
