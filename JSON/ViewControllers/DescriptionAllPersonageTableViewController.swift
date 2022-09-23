//
//  DescriptionTableViewController.swift
//  JSON
//
//  Created by Иван Худяков on 22.09.2022.
//

import UIKit

final class DescriptionAllPersonageTableViewController: UITableViewController {

    private var personages: Personages?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = 100
    }
    
    // MARK: UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        personages?.results.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? DescriptionAllPersonageTableViewCell else { return UITableViewCell() }
        
        if let personage = personages?.results[indexPath.row] {
            cell.configurationCell(with: personage)
        }
        
        return cell
    }
    
    //MARK: - Networking
    func fetchAllPersonage() {
        NetworkManager.shared.fetch(dataType: Personages.self, from: Link.allPersonage.rawValue) { [weak self] result in
            switch result {
                
            case .success(let personages):
                self?.personages = personages
            case .failure(let error):
                print(error)
            }
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}
