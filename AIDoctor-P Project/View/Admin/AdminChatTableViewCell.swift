//
//  AdminChatTableViewCell.swift
//  AIDoctor-P Project
//
//  Created by 구본의 on 2021/12/05.
//

import UIKit

class AdminChatTableViewCell: UITableViewCell {

    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
