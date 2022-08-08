//
//  PhotosCollectionViewController.swift
//  DogsCollectionApp
//
//  Created by Юлия Алдохина on 29/07/22.
//

import UIKit


class HeroesCollectionViewController: UICollectionViewController {
    
    var heroes: [Hero] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchHeroes()
        
    }
    
    private func fetchHeroes() {
        NetworkManager.shared.fetchHero { heroes in
            self.heroes = heroes
            self.collectionView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sharePhoto" {
            let selectedHeroVC = segue.destination as! SelectedHeroViewController
            let cell = sender as! HeroCell
            selectedHeroVC.image = cell.heroImageView.image
        }
    }
    
    
    
// MARK: UICollectionViewDataSource
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        heroes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HeroCell
        
        let defaultLink = "https://api.opendota.com"
        let completeLink = defaultLink + heroes[indexPath.row].img
        
        DispatchQueue.global().async {
            guard let imageData = ImageManager.shared.fetchImage(from: completeLink) else { return}
            DispatchQueue.main.async {
                cell.heroImageView.image = UIImage(data: imageData)
            }
        }
        return cell
    }
    
}

// MARK: extension - UICollectionViewDelegateFlowLayout

extension HeroesCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow: CGFloat = 2
        let paddingWidth = 20 * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        20
    }
    
}

