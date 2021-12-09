//
//  CovidTableViewCell.swift
//  AIDoctor-P Project
//
//  Created by 구본의 on 2021/12/04.
//

import UIKit

class CovidTableViewCell: UITableViewCell {

    @IBOutlet var covidNumLabel: UILabel!
    @IBOutlet var refreshCovid: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
