//
//  PersonViewController.swift
//  JSON
//
//  Created by Иван Худяков on 22.09.2022.
//

import UIKit

final class PersonageViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet var personageImageView: UIImageView!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    
    // MARK: - Networking
    func fetchGordonLunas() {
        NetworkManager.shared.fetch(dataType: Results.self , from: Link.gordonURL.rawValue) { [weak self] result in
            switch result {
            case .success(let personage):
                DispatchQueue.main.async {
                    self?.statusLabel.text = "Status:\(personage.status ?? "")"
                    self?.nameLabel.text = "Name: \(personage.name ?? "")"
                    self?.locationLabel.text = "Location: \(personage.location?.name ?? "")"
                    
                    NetworkManager.shared.fetchImage(from: personage.image) { [weak self] result in
                        switch result {
                        case .success(let imageData):
                            self?.personageImageView.image = UIImage(data: imageData)
                        case .failure(let error):
                            print(error)
                        }
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
