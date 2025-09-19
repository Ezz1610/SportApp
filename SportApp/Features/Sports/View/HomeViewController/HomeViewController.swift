//
//  HomeViewController.swift
//  SportApp
//
//  Created by Nafea Elkassas on 16/09/2025.
//

import UIKit

class HomeViewController: UIViewController {
   //MARK: - Outlets
    
    @IBOutlet weak var sportsCollectionView: UICollectionView!
    
       //MARK: - Properties
    // MARK: - Data
       let sports = ["Football", "Basketball", "Tennis", "Cricket"]
       let sportImages: [UIImage?] = [
           UIImage(named: "football"),
           UIImage(named: "basketball"),
           UIImage(named: "tennis"),
           UIImage(named: "cricket")
       ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "SportsCollectionViewCell", bundle: nil)
                sportsCollectionView.register(nib, forCellWithReuseIdentifier: "sportsCell")
        sportsCollectionView.delegate = self
        sportsCollectionView.dataSource = self
    }



}
   //MARK: - CollectionView Methods
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sports.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sportsCell", for: indexPath) as? SportsCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.sportNameLabel.text = sports[indexPath.item]
        cell.sportImageView.image = sportImages[indexPath.item]
        return cell
    }
    
    // 2 items per row
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.width / 2.5 
        let height = collectionView.frame.height / 2.5
        return CGSize(width: width, height: height)
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let leaguesVC = LeaguesViewController(nibName: "LeaguesViewController", bundle: nil)
           
           switch indexPath.item {
           case 0:
               leaguesVC.selectedSport = .football
           case 1:
               leaguesVC.selectedSport = .basketball
           case 2:
               leaguesVC.selectedSport = .tennis
           case 3:
               leaguesVC.selectedSport = .cricket
           default:
               break
           }
           
           navigationController?.pushViewController(leaguesVC, animated: true)
    }

}
