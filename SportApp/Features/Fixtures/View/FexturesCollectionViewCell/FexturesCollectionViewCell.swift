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
    @IBOutlet weak var rightStackView: UIStackView!
    @IBOutlet weak var leftStackView: UIStackView!
    
    
    //MARK: - LifeCycle
    override func awakeFromNib() {
           super.awakeFromNib()
           setupCell()
       }
       
       override func layoutSubviews() {
           super.layoutSubviews()
           updateCornerRadius()
       }
       
       private func setupCell() {
           self.backgroundColor = .clear
           self.contentView.backgroundColor = .clear
           containerView.backgroundColor = .clear
           pitchImageView.backgroundColor = .clear
           pitchImageView.contentMode = .scaleAspectFill
           containerStackView.backgroundColor = .clear
           rightStackView.backgroundColor = .clear
           leftStackView.backgroundColor = .clear
       }
       
       private func updateCornerRadius() {
           let cornerRadius = containerView.bounds.width / 11
           containerView.layer.cornerRadius = cornerRadius
           containerView.layer.masksToBounds = true
           pitchImageView.layer.cornerRadius = cornerRadius
           pitchImageView.layer.masksToBounds = true
       }
    
    // for no events  
    func configureAsPlaceholder(message: String, imageName: String) {
    firstTeamImageView.isHidden = true
    secondTeamImageView.isHidden = true
    firstTeamLeagueNameLabel.isHidden = true
    secondTeamLeagueNameLabel.isHidden = true
    resultLabel.isHidden = true
    matchDateLabel.isHidden = true
    matchTimeLabel.isHidden = true
    pitchImageView.isHidden = false
    pitchImageView.image = UIImage(named: imageName)
}
    
    // Add this to FexturesCollectionViewCell
    func resetForNormalContent() {
        // Show all normal UI elements
        firstTeamImageView.isHidden = false
        secondTeamImageView.isHidden = false
        firstTeamLeagueNameLabel.isHidden = false
        secondTeamLeagueNameLabel.isHidden = false
        resultLabel.isHidden = false
        matchDateLabel.isHidden = false
        matchTimeLabel.isHidden = false
        
        // Reset any placeholder styling
        pitchImageView.isHidden = false
        pitchImageView.contentMode = .scaleAspectFill // Reset to original
        pitchImageView.alpha = 1.0 // Reset opacity
        
        // Hide placeholder label if you added one
        // placeholderLabel.isHidden = true
        
        // Reset container styling
        containerView.layer.borderWidth = 1
        containerView.backgroundColor = .systemBackground
    }
}
