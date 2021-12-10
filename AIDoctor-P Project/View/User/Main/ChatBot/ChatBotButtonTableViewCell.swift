//
//  ChatBotButtonTableViewCell.swift
//  AIDoctor-P Project
//
//  Created by 구본의 on 2021/12/10.
//

import UIKit

protocol ChatBotButtonDidSelectedDelegate: AnyObject {
    func chatBotButtonDidSelected(index: Int)
}

class ChatBotButtonTableViewCell: UITableViewCell {

    @IBOutlet var buttonTitleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
        self.buttonTitleLabel.layer.masksToBounds = true
        self.buttonTitleLabel.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
