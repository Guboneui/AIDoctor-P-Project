//
//  UserChatTableViewCell.swift
//  AIDoctor-P Project
//
//  Created by 구본의 on 2021/12/04.
//

import UIKit

class UserChatTableViewCell: UITableViewCell {

    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var userChatLabel: UILabel!
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
        
        baseView.layer.cornerRadius = 15
        baseView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
