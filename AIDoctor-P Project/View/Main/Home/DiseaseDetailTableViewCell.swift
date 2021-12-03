//
//  DiseaseDetailTableViewCell.swift
//  AIDoctor-P Project
//
//  Created by 구본의 on 2021/12/04.
//

import UIKit

class DiseaseDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var topBaseView: UIView!
    @IBOutlet weak var mainBaseView: UIView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
        
        topBaseView.layer.cornerRadius = 7
        mainBaseView.layer.cornerRadius = 10
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
