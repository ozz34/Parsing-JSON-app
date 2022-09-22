//
//  DescriptionTableViewController.swift
//  JSON
//
//  Created by Иван Худяков on 22.09.2022.
//

import UIKit

final class DescriptionAllPersonageTableViewController: UITableViewController {

    var personages: Personages!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = 100
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        personages.results.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? DescriptionAllPersonageTableViewCell else { return UITableViewCell() }
        
        let personage = personages.results[indexPath.row]
        cell.configurationCell(with: personage)

        return cell
    }
    
    //MARK: - Networking
    func fetchAllPersonage() {
        guard let url = URL(string: Link.allPersonage.rawValue) else { return }
        let session = URLSession(configuration: .default)
        
         let task = session.dataTask(with: url) {data, _, error in
            guard let data = data
            else { print(error?.localizedDescription ?? "No error description")
            return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                self.personages = try jsonDecoder.decode(Personages.self, from: data)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}
