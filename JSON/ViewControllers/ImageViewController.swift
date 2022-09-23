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
    
    //MARK: - Networking
    private func fetchImage() {
        
        NetworkManager.shared.fetchImage(from: Link.imageURL.rawValue, completion: { [weak self] result in
            switch result {
                
            case .success(let imageData):
                self?.imageView.image = UIImage(data: imageData)
                self?.activityIndicator.stopAnimating()
            case .failure(let error):
                print(error)
            }
        })
        }
    }

