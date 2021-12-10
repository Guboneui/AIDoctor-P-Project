//
//  ImageChatBotTableViewCell.swift
//  AIDoctor-P Project
//
//  Created by 구본의 on 2021/12/10.
//

import UIKit

class ImageChatBotTableViewCell: UITableViewCell {
    
    var k = ["a", "b", "c", "d", "e"]
    
    @IBOutlet var baseView: UIView!
    @IBOutlet var chatBotImage: UIImageView!
    @IBOutlet var contentsLabel: UILabel!
    @IBOutlet var buttonTableView: UITableView!
    @IBOutlet var buttonTableViewHeight: NSLayoutConstraint!
    
    weak var delegate: ChatBotButtonDidSelectedDelegate?
    
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
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}


extension ImageChatBotTableViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatBotButtonTableViewCell", for: indexPath) as! ChatBotButtonTableViewCell
        cell.selectionStyle = .none
        cell.buttonTitleLabel.text = self.k[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.chatBotButtonDidSelected()
        print(self.k[indexPath.row])
        print("ImageChatBot - didSelectedIndex: \(indexPath.row)")
    }
    
 
    
}
