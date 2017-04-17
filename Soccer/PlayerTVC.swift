//
//  PlayerTVC.swift
//  Soccer
//
//  Created by Pearl on 4/16/2560 BE.
//  Copyright © 2560 Pearl. All rights reserved.
//

import UIKit

class PlayerTVC: UITableViewCell {

    var player:Player?
    var number:Int?

    var iconImage = UIImageView(frame: CGRectMake(0,0,0,0))
    var nameLabel = UILabel(frame: CGRectMake(0,0,0,0))
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func getPlayer() -> Player {return self.player!}
    func getNameLabel() -> UILabel {return self.nameLabel}
}
