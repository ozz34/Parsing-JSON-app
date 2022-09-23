//
//  DescriptionTableViewController.swift
//  JSON
//
//  Created by Иван Худяков on 22.09.2022.
//

import UIKit

final class DescriptionAllPersonageTableViewController: UITableViewController {

    var personages: Personages?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = 100
    }
    
    // MARK: - Table view data source
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
        NetworkManager.shared.fetchAll(url: Link.allPersonage.rawValue) { personages in
            self.personages = personages
            DispatchQueue.main.async {
                    self.tableView.reloadData()
            }
        }
    }
}
