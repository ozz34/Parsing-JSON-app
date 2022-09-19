//
//  CollectionViewController.swift
//  JSON
//
//  Created by Иван Худяков on 19.09.2022.
//

import UIKit

enum UserAction: String, CaseIterable {
    case showImage = "Show image"
    case fetchGazorpazorpfield = "Gazorpazorpfield"
    case fetchGordonLunas = "Gordon Lunas"
    case fetchRisottoGroupon = "Risotto Groupon"
}

enum Link: String {
    case imageURL = "https://u-stena.ru/upload/iblock/8c2/8c2f36e88e65de30b8712b772cdf134a.jpg"
    case gazorURL = "https://rickandmortyapi.com/api/character/136"
    case gordonURL = "https://rickandmortyapi.com/api/character/149"
    case risottoURL = "https://rickandmortyapi.com/api/character/296"
}

final class MainViewController: UICollectionViewController {
    
    private let userActions = UserAction.allCases
    
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        userActions.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? UserActionCell else { return  UICollectionViewCell() } 
        
        let userAction = userActions[indexPath.item]
        cell.nameButtonLabel.text = userAction.rawValue
        cell.nameButtonLabel.textColor = .white
        cell.backgroundColor = .red
        cell.layer.cornerRadius = 10
        
        return cell
    }

    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let userAction = userActions[indexPath.item]
        
        switch userAction {
        case .showImage: performSegue(withIdentifier: "showPicture", sender: nil)
        case .fetchGazorpazorpfield: fetchGazorpazorpfield()
        case .fetchGordonLunas: fetchGordonLunas()
        case .fetchRisottoGroupon: fetchRisottoGroupon()
        }
    }
    
    private func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
    // MARK: UICollectionViewDelegateFlowLayout
    extension MainViewController: UICollectionViewDelegateFlowLayout {

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 60, height: 100)
    }
}

    extension MainViewController {
    
        func fetchGazorpazorpfield() {
            guard let url = URL(string: Link.gazorURL.rawValue) else { return }
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) {data, _, error in
                guard let data = data
                else { print(error?.localizedDescription ?? "No error description")
                return
                }
                
                let jsonDecoder = JSONDecoder()
                do {
                    let personage = try jsonDecoder.decode(Personage.self, from: data)
                    self.alert(title: "Success",
                               message: "You can see the results in the Debug area")
                } catch {
                    print(error.localizedDescription)
                    self.alert(title: "Failed",
                               message: "You can see error in the Debug aria")
                }
            }
            task.resume()
        }
        
        func fetchGordonLunas() {
            guard let url = URL(string: Link.gordonURL.rawValue) else { return }
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, _, error in
                guard let data = data
                else { print(error?.localizedDescription ?? "No error description")
                    return
                }
                
                let jsonDecoder = JSONDecoder()
                do {
                    let personage = try jsonDecoder.decode(Personage.self, from: data)
                    self.alert( title: "Success",
                                message: "You can see the results in the Debug area")
                } catch {
                    print(error.localizedDescription)
                    self.alert( title: "Failed",
                                message: "You can see error in the Debug aria")
                }
            }
            task.resume()
        }
        
        func fetchRisottoGroupon() {
            guard let url = URL(string: Link.risottoURL.rawValue) else { return }
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, _, error in
                guard let data = data
                else { print(error?.localizedDescription ?? "No error description")
                    return
                }
                
                let jsonDecoder = JSONDecoder()
                do {
                    let personage = try jsonDecoder.decode(Personage.self, from: data)
                    self.alert( title: "Success",
                                message: "You can see the results in the Debug area")
                }
                catch {
                    print(error.localizedDescription)
                    self.alert( title: "Failed",
                                message: "You can see error in the Debug aria")
                }
            }
            task.resume()
        }
}

