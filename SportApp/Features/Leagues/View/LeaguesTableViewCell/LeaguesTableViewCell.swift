//
//  LeaguesTableViewCell.swift
//  SportApp
//
//  Created by Nafea Elkassas on 18/09/2025.
//

import UIKit

class LeaguesTableViewCell: UITableViewCell {
    
   //MARK: - Outlets
    @IBOutlet weak var leaguesContentView: UIView!
    @IBOutlet weak var leaguesImageView: UIImageView!
    @IBOutlet weak var leaguesNameLabel: UILabel!
    
    @IBOutlet weak var contentStackView: UIStackView!
    @IBOutlet weak var containerView: UIView!
    //MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 12
        contentStackView.layer.cornerRadius = 12
        leaguesContentView.layer.cornerRadius = 12
        leaguesContentView.layer.masksToBounds = false
        leaguesContentView.layer.shadowColor = UIColor.black.cgColor
        leaguesContentView.layer.shadowOpacity = 0.1
        leaguesContentView.layer.shadowOffset = CGSize(width: 0, height: 1)
        leaguesContentView.layer.shadowRadius = 4
        
        
        leaguesImageView.contentMode = .scaleAspectFit
        leaguesImageView.clipsToBounds = true
        
        leaguesImageView.layer.borderWidth = 0.5
        leaguesImageView.layer.borderColor = UIColor.lightGray.cgColor
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        // This is where bounds are final, so cornerRadius works correctly
        leaguesImageView.layer.cornerRadius = leaguesImageView.bounds.height / 2
    }
}
