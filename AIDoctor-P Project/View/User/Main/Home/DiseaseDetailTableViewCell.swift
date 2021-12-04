//
//  DiseaseDetailTableViewCell.swift
//  AIDoctor-P Project
//
//  Created by 구본의 on 2021/12/04.
//

import UIKit

protocol DiseaseDetailViewFirstDelegate: AnyObject {
    func goDiseaseView()
}


class DiseaseDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var topBaseView: UIView!
    @IBOutlet weak var mainBaseView: UIView!
    @IBOutlet weak var showMoreStackView: UIStackView!
    
    weak var delegate: DiseaseDetailViewFirstDelegate?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
        
        topBaseView.layer.cornerRadius = 7
        mainBaseView.layer.cornerRadius = 10
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tap = UITapGestureRecognizer(target: self, action: #selector(showMoreTapGesture))
        showMoreStackView.addGestureRecognizer(tap)
    }
    
    @objc func showMoreTapGesture(_ sender: UITapGestureRecognizer) {

        self.delegate?.goDiseaseView()
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}