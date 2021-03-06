//
//  OnlyImageTableViewCell.swift
//  AIDoctor-P Project
//
//  Created by 구본의 on 2021/12/12.
//

import UIKit

class OnlyImageTableViewCell: UITableViewCell {

    @IBOutlet var baseView: UIView!
    @IBOutlet var chatBotImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
        
        baseView.layer.cornerRadius = 15
        baseView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMaxXMinYCorner)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.chatBotImage.image = nil
    }
  
}
