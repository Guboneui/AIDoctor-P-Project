//
//  ChatBotTableViewCell.swift
//  AIDoctor-P Project
//
//  Created by 구본의 on 2021/12/04.
//

import UIKit

class ChatBotTableViewCell: UITableViewCell {

    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
        
        baseView.layer.cornerRadius = 15
        baseView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMaxXMinYCorner)
        firstButton.layer.cornerRadius = 10
        secondButton.layer.cornerRadius = 10
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
