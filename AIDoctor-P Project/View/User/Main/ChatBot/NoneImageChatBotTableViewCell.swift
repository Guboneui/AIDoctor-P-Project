//
//  NoneImageChatBotTableViewCell.swift
//  AIDoctor-P Project
//
//  Created by 구본의 on 2021/12/10.
//

import UIKit

class NoneImageChatBotTableViewCell: UITableViewCell {

    @IBOutlet var baseView: UIView!
    @IBOutlet var contentsLabel: UILabel!
    @IBOutlet var buttonTableView: UITableView!
    @IBOutlet var buttonTableViewHeight: NSLayoutConstraint!
    
    var cellIndex: Int?
    
    weak var mainView: ChatBotViewController?
    
    weak var delegate: ChatBotButtonDidSelectedDelegate?
    
    var buttonList: [ListItem] = [] {
        didSet {
            self.buttonTableView.reloadData()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.buttonTableView.delegate = self
        self.buttonTableView.dataSource = self
        self.buttonTableView.separatorStyle = .none
        self.buttonTableView.register(UINib(nibName: "ChatBotButtonTableViewCell", bundle: nil), forCellReuseIdentifier: "ChatBotButtonTableViewCell")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
        
        baseView.layer.cornerRadius = 15
        baseView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMaxXMinYCorner)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.contentsLabel.attributedText = nil
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension NoneImageChatBotTableViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.buttonList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatBotButtonTableViewCell", for: indexPath) as! ChatBotButtonTableViewCell
        cell.selectionStyle = .none
        let data = self.buttonList[indexPath.row]
        cell.buttonTitleLabel.text = data.value
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.chatBotButtonDidSelected(arrayIndex: self.cellIndex!, index: indexPath.row)
        AIDoctorLog.debug("NoneImageChatBot - didSelectedIndex: \(indexPath.row)")
    }
   
}
