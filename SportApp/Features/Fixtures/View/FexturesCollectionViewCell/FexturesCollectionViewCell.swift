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
           fixLabelConstraints()
           firstTeamImageView.widthAnchor.constraint(equalToConstant:90).isActive = true
               firstTeamImageView.heightAnchor.constraint(equalToConstant: 90).isActive = true
               
               secondTeamImageView.widthAnchor.constraint(equalToConstant: 90).isActive = true
               secondTeamImageView.heightAnchor.constraint(equalToConstant: 90).isActive = true
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

    
    func resetForNormalContent() {
        firstTeamImageView.isHidden = false
        secondTeamImageView.isHidden = false
        firstTeamLeagueNameLabel.isHidden = false
        secondTeamLeagueNameLabel.isHidden = false
        resultLabel.isHidden = false
        matchDateLabel.isHidden = false
        matchTimeLabel.isHidden = false
        
        pitchImageView.isHidden = false
        pitchImageView.contentMode = .scaleAspectFill
        pitchImageView.alpha = 1.0

        containerView.layer.borderWidth = 1
        containerView.backgroundColor = .systemBackground
    }
    
    // for solving shrinking date and time labels
    private func fixLabelConstraints() {
        matchDateLabel.translatesAutoresizingMaskIntoConstraints = false
        matchTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        matchDateLabel.numberOfLines = 1
        matchDateLabel.lineBreakMode = .byTruncatingTail
        matchDateLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        matchDateLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        matchTimeLabel.numberOfLines = 1
        matchTimeLabel.lineBreakMode = .byTruncatingTail
        matchTimeLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        matchTimeLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        if let dateTimeStackView = matchDateLabel.superview as? UIStackView {
            dateTimeStackView.spacing = 8
        }
    }
}
