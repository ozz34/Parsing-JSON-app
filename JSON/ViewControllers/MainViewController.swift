//
//  CollectionViewController.swift
//  JSON
//
//  Created by Иван Худяков on 19.09.2022.
//

import UIKit

enum UserAction: String, CaseIterable {
    case showImage = "Show image"
    case fetchAllPersonage = "All personage"
    case fetchGordonLunas = "Gordon Lunas"
}

final class MainViewController: UICollectionViewController {
    
    private let userActions = UserAction.allCases
    
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAllDescription" {
            guard let destinationVC = segue.destination as? DescriptionAllPersonageTableViewController else { return }
            destinationVC.fetchAllPersonage()
        } else if segue.identifier == "showPersonDescription" {
            guard let personVC = segue.destination as? PersonageViewController else { return }
            personVC.fetchGordonLunas()
        }
    }
    
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
        case .fetchAllPersonage: performSegue(withIdentifier: "showAllDescription", sender: nil)
        case .fetchGordonLunas: performSegue(withIdentifier: "showPersonDescription", sender: nil)
        }
    }
}
    // MARK: UICollectionViewDelegateFlowLayout
    extension MainViewController: UICollectionViewDelegateFlowLayout {

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 60, height: 100)
    }
}

