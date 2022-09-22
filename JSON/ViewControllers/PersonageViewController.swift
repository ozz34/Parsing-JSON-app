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
    
    var personage: Results!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func fetchGordonLunas() {
        
        guard let url = URL(string: Link.gordonURL.rawValue) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                self.personage = try JSONDecoder().decode(Results.self, from: data)
            }
            catch {
                print(error.localizedDescription)
            }
        }.resume()
        
        configurationPerson()
    }
    
    private func configurationPerson() {
        
        statusLabel.text = "Status:\(personage.status ?? "")"
        nameLabel.text = "Name: \(personage.name ?? "")"
        locationLabel.text = "Location: \(personage.location?.name ?? "")"
        
        NetworkManager.shared.fetchImage(from: personage.image) { imageData in
            self.personageImageView.image = UIImage(data: imageData)
        }
    }
}
