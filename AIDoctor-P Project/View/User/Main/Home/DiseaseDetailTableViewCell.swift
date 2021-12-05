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
    @IBOutlet weak var showMoreStackView: UIStackView!
    
    @IBOutlet var diseaseTitleLabel: UILabel!
    @IBOutlet var diseaseDescriptionLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
        
        topBaseView.layer.cornerRadius = 7
        mainBaseView.layer.cornerRadius = 10
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
