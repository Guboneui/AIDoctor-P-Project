//
//  HospitalImageTableViewCell.swift
//  AIDoctor-P Project
//
//  Created by 구본의 on 2021/12/04.
//

import UIKit

class HospitalDetailTableViewCell: UITableViewCell, MTMapViewDelegate{
    
    @IBOutlet var locationLabel: UILabel!
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
        
        mapView.delegate = self
        mapView.baseMapType = .standard
        mapView.setMapCenter(MTMapPoint(geoCoord: MTMapPointGeo(latitude:  37.4476, longitude: 127.1270)), zoomLevel: 1, animated: true)
        self.mapPoint = MTMapPoint(geoCoord: MTMapPointGeo(latitude:  37.4476, longitude: 127.1270))
        poiItem = MTMapPOIItem()
        poiItem?.markerType = MTMapPOIItemMarkerType.customImage
        poiItem?.customImage = UIImage(named: "location")
        //mapView.isUserInteractionEnabled = false
        poiItem?.mapPoint = mapPoint
        poiItem?.itemName = "복정그린치과의원"
        mapView.add(poiItem)
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
