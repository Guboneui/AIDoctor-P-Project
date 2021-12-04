//
//  DiseaseTableViewCell.swift
//  AIDoctor-P Project
//
//  Created by 구본의 on 2021/12/04.
//

import UIKit

protocol DetailViewSecondDelegate: AnyObject {
    func goDiseaseView()
    
}

class DiseaseTableViewCell: UITableViewCell {

    @IBOutlet weak var diseaseTableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    let arr = ["a", "b", "c"]
    
    weak var delegate: DetailViewSecondDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setTableView()
    }
    
    func setTableView() {
        layoutIfNeeded()
        diseaseTableView.delegate = self
        diseaseTableView.dataSource = self
        diseaseTableView.separatorStyle = .none
        diseaseTableView.register(UINib(nibName: "DiseaseDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "DiseaseDetailTableViewCell")
        
        tableViewHeight.constant = CGFloat(70 * self.arr.count)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}

extension DiseaseTableViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DiseaseDetailTableViewCell", for: indexPath) as! DiseaseDetailTableViewCell
        cell.selectionStyle = .none
        cell.delegate = self
        return cell
    }
}

extension DiseaseTableViewCell: DiseaseDetailViewFirstDelegate {
    func goDiseaseView() {
        self.delegate?.goDiseaseView()
    }
}
