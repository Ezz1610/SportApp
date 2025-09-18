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
    
       //MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        leaguesImageView.layer.cornerRadius = leaguesImageView.bounds.width / 2
        leaguesImageView.clipsToBounds = true
            
          
        leaguesImageView.layer.borderWidth = 0.1
        leaguesImageView.layer.borderColor = UIColor.lightGray.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
