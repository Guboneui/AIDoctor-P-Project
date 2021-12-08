//
//  HospitalTableViewCell.swift
//  AIDoctor-P Project
//
//  Created by 구본의 on 2021/12/04.
//

import UIKit



protocol HospitalInfoDelegate: AnyObject {
    func hospitalInfo(hospitalInfo: HospitalInfo)
}


class HospitalTableViewCell: UITableViewCell {

    
    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    var hospitalInfo: [HospitalInfo] = [] {
        didSet {
            self.mainCollectionView.reloadData()
            AIDoctorLog.debug("HospitalTableViewCell - mainCollectionView - Reload")
        }
    }
    
    weak var delegate: HospitalInfoDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setCollectionView()
    }
    
    func setCollectionView() {
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        mainCollectionView.register(UINib(nibName: "HospitalDetailCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HospitalDetailCollectionViewCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension HospitalTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.hospitalInfo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HospitalDetailCollectionViewCell", for: indexPath) as! HospitalDetailCollectionViewCell
        let data = self.hospitalInfo[indexPath.item]
        cell.categoryLabel.text = data.className
        cell.nameLabel.text = data.name
        cell.locationLabel.text = data.addr
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = self.hospitalInfo[indexPath.item]
        self.delegate?.hospitalInfo(hospitalInfo: data)
    }
}


extension HospitalTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 220)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
       return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

