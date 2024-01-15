//
//  MapVC.swift
//  SHARMIVAL
//
//  Created by Emojiios on 08/09/2022.
//

import UIKit
import MapKit
import SDWebImage
import GoogleMaps
import CoreLocation

class MapVC: ViewController ,GMSMapViewDelegate {
    
    var markers = [GMSMarker]()
    var Areas = [MapPlaces]()
    let customMarkerWidth = ControlWidth(60)
    let customMarkerHeight = ControlWidth(60)
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpItem()
        view.backgroundColor = .white
    }
    
    fileprivate func SetUpItem() {
        view.addSubview(mapView)
        mapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        mapView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        
        view.addSubview(TopView)
        TopView.topAnchor.constraint(equalTo: view.topAnchor, constant: ControlHeight(60)).isActive = true
        TopView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: ControlX(15)).isActive = true
        TopView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: ControlX(-15)).isActive = true
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Areas.count == 0 {
        mapView.delegate = self
        GetDataMapPlaces()
        }
    }
    
    var mapView: GMSMapView = {
        let v = GMSMapView()
        v.mapType = .satellite
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    func addMarkers() {
        markers.removeAll()
        for (index, place) in Areas.enumerated() {
            let marker = GMSMarker()
            let customMarker = CustomMarkerView(frame: CGRect(x: 0, y: 0, width: customMarkerWidth, height: customMarkerHeight), imageName: place.icon, tag: index)
            marker.iconView = customMarker
            
            SDWebImageManager.shared.loadImage(
            with: URL(string: place.icon ?? ""),
            options: .highPriority,
            progress: nil) { (image, data, error, cacheType, isFinished, imageUrl) in
                marker.icon = image
            }
            
            marker.position = CLLocationCoordinate2D(latitude: place.lat ?? 0, longitude: place.long ?? 0)
            marker.infoWindowAnchor = CGPoint(x: 0.5, y: 0)
            marker.map = self.mapView
            marker.zIndex = Int32(index)
            marker.userData = place
            markers.append(marker)
        }
    }
    
    func focusMapToShowAllMarkers() {
        if let firstLocation = markers.first?.position {
        var bounds =  GMSCoordinateBounds(coordinate: firstLocation, coordinate: firstLocation)
        for marker in markers {
        bounds = bounds.includingCoordinate(marker.position)
        }
        let update = GMSCameraUpdate.fit(bounds, withPadding: 20)
        self.mapView.animate(with: update)
        }
    }
    
    
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        if let place = marker.userData as? MapPlaces {
            marker.tracksInfoWindowChanges = true
            let infoWindow = CustomMarkerInfoWindow()
            infoWindow.tag = 5555
            let height: CGFloat = ControlWidth(65)
            let paddingWith = height + 16 + 32
            infoWindow.imgView.sd_setImage(with: URL(string: place.icon ?? ""), placeholderImage: UIImage(named: "Group 26056"))
            infoWindow.frame = CGRect(x: 0, y: 0, width: getEstimatedWidthForMarker(place, padding: paddingWith) + paddingWith, height: height)
            infoWindow.txtLabel.text = place.name
            infoWindow.subtitleLabel.text = place.details ?? ""
            return place.name != nil ? infoWindow : nil
        }
        return nil
    }
        
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        if let place = marker.userData as? MapPlaces {
            print("Info window tapped", place)
        }
    }
    
    func getEstimatedWidthForMarker(_ place: MapPlaces, padding: CGFloat) -> CGFloat {
        var estimatedWidth: CGFloat = 0
        let infoWindow = CustomMarkerInfoWindow()
        let maxWidth = (UIDevice.current.userInterfaceIdiom == .pad ? UIScreen.main.bounds.width * 0.7 : UIScreen.main.bounds.width * 0.8) - padding
        let titleWidth = (place.name ?? "").textSizeWithFont(infoWindow.txtLabel.font)
        let subtitleWidth = (place.details ?? "").textSizeWithFont(infoWindow.subtitleLabel.font)
        estimatedWidth = min(maxWidth, max(titleWidth.width , subtitleWidth.width))
        
        return estimatedWidth
    }
    
    func GetDataMapPlaces()  {
    guard let url = defaults.string(forKey: "API") else{
    LodBaseUrl()
    self.ViewDots.endRefreshing {}
    ShowMessageAlert("ErrorIcon", "Error".localizable, "Something went wrong while processing your request, please try again later".localizable, true, {})
    return
    }
    let api = "\(url + GetMapPlaces)"
        
    let token = defaults.string(forKey: "jwt") ?? ""
    let carnavalId = defaults.string(forKey: "carnavalId") ?? ""
    let udid = UIDevice.current.identifierForVendor?.uuidString ?? ""
    let parameters:[String:Any] = ["appId": "513faa96-afb6-4171-8d74-1a04c19092d6",
                                    "Platform": "I",
                                    "deviceID": udid,
                                    "carnavalId": carnavalId]

    self.ViewDots.beginRefreshing()
    PostAPI(api: api, token: token, parameters: parameters) { _ in
    } DictionaryData: { ـ in
    } ArrayOfDictionary: { data in
    for item in data {
    self.Areas.append(MapPlaces(dictionary: item))
    if self.Areas.count == data.count {
    self.LocationFirst()
    }
    }
            
    self.addMarkers()
    self.focusMapToShowAllMarkers()
    self.ViewDots.endRefreshing {}
    } Err: { error in
    self.ViewDots.endRefreshing(error, .error) {}
    }
    }
    
    func LocationFirst() {
        let newLocation = CLLocationCoordinate2D(latitude: self.Areas.last?.lat ?? 27.9533325306192, longitude: self.Areas.last?.long ?? 34.363368111813564)
        mapView.padding = UIEdgeInsets(top: 0, left: ControlX(10), bottom: ControlWidth(20), right: ControlX(10))
        self.mapView.camera = GMSCameraPosition.camera(withTarget: newLocation, zoom: 10)
    }
    
}

