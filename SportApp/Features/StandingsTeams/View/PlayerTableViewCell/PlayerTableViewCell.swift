//
//  PlayerTableViewCell.swift
//  SportApp
//
//  Created by Nafea Elkassas on 24/09/2025.
//

import UIKit

class PlayerTableViewCell: UITableViewCell {

       //MARK: - Outlets
    
    @IBOutlet weak var playerImageView: UIImageView!
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var playerRoleLabel: UILabel!
    
       //MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
