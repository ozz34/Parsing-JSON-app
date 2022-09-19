//
//  CollectionViewController.swift
//  JSON
//
//  Created by Иван Худяков on 19.09.2022.
//

import UIKit

enum UserAction: String, CaseIterable {
    case showImage = "Show Image"
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? UserActionCell else {return  UICollectionViewCell()}
    
        let userAction = userActions[indexPath.item]
        cell.nameButtonLabel.text = userAction.rawValue
        cell.backgroundColor = .red
    
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
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 60, height: 100)
    }
}

extension MainViewController {
    func fetchGazorpazorpfield() {
        
    }
    
    func fetchGordonLunas() {
        
    }
    
    func fetchRisottoGroupon() {
        
    }
}
