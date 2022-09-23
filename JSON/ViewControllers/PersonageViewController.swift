//
//  PersonViewController.swift
//  JSON
//
//  Created by Иван Худяков on 22.09.2022.
//

import UIKit

class PersonageViewController: UIViewController {
    
    @IBOutlet var personageImageView: UIImageView!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    
    var personage: Results?
    
    func fetchGordonLunas() {
        
        NetworkManager.shared.fetchPerson(url: Link.gordonURL.rawValue) { personage in
            DispatchQueue.main.async {
                self.statusLabel.text = "Status:\(personage.status ?? "")"
                self.nameLabel.text = "Name: \(personage.name ?? "")"
                self.locationLabel.text = "Location: \(personage.location?.name ?? "")"
            }
            
            NetworkManager.shared.fetchImage(from: personage.image) { imageData in
                self.personageImageView.image = UIImage(data: imageData)
            }
        }
    }
}
        
    
