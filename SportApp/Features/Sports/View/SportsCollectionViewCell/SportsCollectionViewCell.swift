//
//  SportsCollectionViewCell.swift
//  SportApp
//
//  Created by Nafea Elkassas on 16/09/2025.
//

import UIKit

class SportsCollectionViewCell: UICollectionViewCell {

       //MARK: - Outlets
    @IBOutlet weak var sportImageView: UIImageView!
    
    @IBOutlet weak var sportNameLabel: UILabel!
    
    @IBOutlet weak var containerStackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerStackView.layer.cornerRadius = containerStackView.bounds.height / 4
        sportImageView.layer.cornerRadius = sportImageView.bounds.height / 4
        sportImageView.layer.borderWidth = 0.5
        sportImageView.layer.borderColor = UIColor.lightGray.cgColor
        addSomeShadow()
    }
    
    func addSomeShadow(){
        contentView.layer.cornerRadius = 12
            contentView.layer.shadowColor = UIColor.black.cgColor
            contentView.layer.shadowOpacity = 0.2
            contentView.layer.shadowOffset = CGSize(width: 0, height: 4)
            contentView.layer.shadowRadius = 6
            contentView.layer.masksToBounds = false
        sportImageView.layer.shadowColor = UIColor.black.cgColor
            sportImageView.layer.shadowOpacity = 0.25
            sportImageView.layer.shadowOffset = CGSize(width: 0, height: 2)
            sportImageView.layer.shadowRadius = 4
            sportImageView.layer.masksToBounds = false
    }

}
