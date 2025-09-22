//
//  FexturesCollectionViewCell.swift
//  SportApp
//
//  Created by Nafea Elkassas on 21/09/2025.
//

import UIKit

class FexturesCollectionViewCell: UICollectionViewCell {
       //MARK: - Outlets
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var firstTeamImageView: UIImageView!
    
    @IBOutlet weak var firstTeamLeagueNameLabel: UILabel!
    
    @IBOutlet weak var secondTeamImageView: UIImageView!
    
    @IBOutlet weak var secondTeamLeagueNameLabel: UILabel!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var matchDateLabel: UILabel!
    @IBOutlet weak var matchTimeLabel: UILabel!
    
    @IBOutlet weak var pitchImageView: UIImageView!
    
    @IBOutlet weak var containerStackView: UIStackView!
    //MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = containerView.frame.width / 11
        pitchImageView.layer.cornerRadius = pitchImageView.frame.width / 11
        containerStackView.layer.cornerRadius = containerStackView.frame.width / 11
    }

}
