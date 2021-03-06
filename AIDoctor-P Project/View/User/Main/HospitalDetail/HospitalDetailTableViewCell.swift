//
//  HospitalImageTableViewCell.swift
//  AIDoctor-P Project
//
//  Created by 구본의 on 2021/12/04.
//

import UIKit

class HospitalDetailTableViewCell: UITableViewCell, MTMapViewDelegate{
    
    
    
    @IBOutlet var nameLabel: UILabel!
    
    @IBOutlet var linkLabel: UILabel!
    @IBOutlet var phoneNumberLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    var xPos: Float = 0.0 
    var yPos: Float = 0.0 {
        didSet {
            mapView.setMapCenter(MTMapPoint(geoCoord: MTMapPointGeo(latitude:  Double(self.yPos), longitude: Double(self.xPos))), zoomLevel: 1, animated: true)
            self.mapPoint = MTMapPoint(geoCoord: MTMapPointGeo(latitude:  Double(self.yPos), longitude: Double(self.xPos)))
            poiItem = MTMapPOIItem()
            poiItem?.markerType = MTMapPOIItemMarkerType.customImage
            poiItem?.customImage = UIImage(named: "mapPin")
            //mapView.isUserInteractionEnabled = false
            poiItem?.mapPoint = mapPoint
            poiItem?.itemName = self.nameLabel.text
            mapView.add(poiItem)
        }
    }
    
    
   
    var mapPoint: MTMapPoint?
    var poiItem: MTMapPOIItem?
    let mapView: MTMapView = {
        let mapView = MTMapView()
        return mapView
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layoutIfNeeded()
        self.contentView.addSubview(mapView)
        self.mapView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: self.locationLabel.bottomAnchor, constant: 20),
            mapView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 30),
            mapView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -30),
            mapView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -75),
            mapView.heightAnchor.constraint(equalTo: self.mapView.widthAnchor, multiplier: 0.5)
        ])
        
//        mapView.delegate = self
//        mapView.baseMapType = .standard
//        mapView.setMapCenter(MTMapPoint(geoCoord: MTMapPointGeo(latitude:  37.4476, longitude: 127.1270)), zoomLevel: 1, animated: true)
//        self.mapPoint = MTMapPoint(geoCoord: MTMapPointGeo(latitude:  37.4476, longitude: 127.1270))
//        poiItem = MTMapPOIItem()
//        poiItem?.markerType = MTMapPOIItemMarkerType.customImage
//        poiItem?.customImage = UIImage(named: "location")
//        //mapView.isUserInteractionEnabled = false
//        poiItem?.mapPoint = mapPoint
//        poiItem?.itemName = self.nameLabel.text
//        mapView.add(poiItem)
        
        mapView.delegate = self
        mapView.baseMapType = .standard
//        mapView.setMapCenter(MTMapPoint(geoCoord: MTMapPointGeo(latitude:  Double(self.yPos), longitude: Double(self.xPos))), zoomLevel: 1, animated: true)
//        self.mapPoint = MTMapPoint(geoCoord: MTMapPointGeo(latitude:  Double(self.yPos), longitude: Double(self.xPos)))
//        poiItem = MTMapPOIItem()
//        poiItem?.markerType = MTMapPOIItemMarkerType.customImage
//        poiItem?.customImage = UIImage(named: "location")
//        //mapView.isUserInteractionEnabled = false
//        poiItem?.mapPoint = mapPoint
//        poiItem?.itemName = self.nameLabel.text
//        mapView.add(poiItem)
        
        let callingTapGesture = UITapGestureRecognizer(target: self, action: #selector(callingTapGesture))
        self.phoneNumberLabel.isUserInteractionEnabled = true
        self.phoneNumberLabel.addGestureRecognizer(callingTapGesture)
        
        let linkTapGesture = UITapGestureRecognizer(target: self, action: #selector(linkTapGesture))
        self.linkLabel.isUserInteractionEnabled = true
        self.linkLabel.addGestureRecognizer(linkTapGesture)
 
    }
    
    @objc func callingTapGesture(_ sender: UITapGestureRecognizer) {
        print("calling: \(self.phoneNumberLabel.text ?? "")")
        
//        if let numberURL = NSURL(string: "tel://" + self.phoneNumberLabel.text!), UIApplication.shared.canOpenURL(numberURL as URL) {
//            UIApplication.shared.open(numberURL as URL, options: [:], completionHandler: nil)
//        }
        
    }
    
    @objc func linkTapGesture(_ sender: UITapGestureRecognizer) {
        print("link: \(self.linkLabel.text ?? "")")
        
        if let url = URL(string: self.linkLabel.text ?? "") {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.mapView.clipsToBounds = true
        self.mapView.layer.borderWidth = 2
        self.mapView.layer.borderColor = UIColor(named: "mapBorder")?.cgColor
        self.mapView.layer.cornerRadius = 10
        
        
        layoutIfNeeded()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
}
