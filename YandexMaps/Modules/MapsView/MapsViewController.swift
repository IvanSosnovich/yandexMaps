//
//  MapsViewController.swift
//  YandexMaps
//
//  Created by MIkkyMouse on 25.08.2020.
//  Copyright © 2020 Ivan Sosnovich. All rights reserved.
//

import UIKit
import CoreLocation
import YandexMapKit

class MapsViewController: UIViewController {
    
    var coordinate = LocationAddressBook(name: "no location", latitude: 0, longitude: 0)
    let managerLocation = CLLocationManager()
    @IBOutlet weak var mapView: YMKMapView!
    let moveButton = UIButton(type: .system)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        managerLocation.delegate = self
        managerLocation.startUpdatingLocation()
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = "\(coordinate.name)"
    }
    
    
}
// MARK: - user location service
extension MapsViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        //Статус авторизации
        switch status {
        //Если он не определён (то есть ни одного запроса на авторизацию не было, то попросим базовую авторизацию)
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        //Если авторизация базовая, то попросим предоставить полную
        case .authorizedWhenInUse:
            print("Включаем базовые функции")
            manager.requestAlwaysAuthorization()
        //Хи-хи
        default:
            print("Отключаем локацию")
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locationUser = locations.last
        guard let location = locationUser else {return}
        moveMaps(to: location)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        //Если ошибку можно превратить в ошибку геопоозии, то сделаем это
        guard let locationError = error as? CLError else {
            //Иначе выведем как есть
            print(error)
            return
        }
        //Если получилось, то можно получить локализованное описание ошибки
        NSLog(locationError.localizedDescription)
    }
    
}

// MARK: - move to get location
extension MapsViewController {
    
    func moveMaps(to location: CLLocation) {
        self.managerLocation.stopUpdatingLocation()
        self.mapView.mapWindow.map.move(
            with: YMKCameraPosition.init(target: YMKPoint(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude), zoom: 15, azimuth: 0, tilt: 0),
            animationType: YMKAnimation(type: YMKAnimationType.smooth, duration: 5),
            cameraCallback: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
           //self.moveButton.setTitle("\(self.coordinate!.name)", for: .normal)
         
            self.setupInfoView(with: location)
        }
    }
}

//MARK: - setup info label
extension MapsViewController {
    func setupInfoView(with location: CLLocation) {
        let geogoder = CLGeocoder()
        
        geogoder.reverseGeocodeLocation(location) { (placeMark, _) in
            guard let place = placeMark else {return}
            let lastPlace = place.last
                guard let userPlace = lastPlace?.thoroughfare,
                      let userPlaceInfo = lastPlace?.subThoroughfare
                else {return}
                let address = userPlace + " " + userPlaceInfo
           
            self.greatLabelInfo(with: address, for: location)
            
        }
    }
}


//MARK: - Great object map

extension MapsViewController {
    func greatLabelInfo(with text: String, for location: CLLocation) {
        let mapObjects = mapView.mapWindow.map.mapObjects
        let textView =
                   UITextView(frame: CGRect(x: 0, y: 0, width: 200, height: 80))
        textView.isOpaque = false
        textView.backgroundColor = UIColor.clear.withAlphaComponent(0.0)
        textView.textAlignment = .center
        textView.text = text
        textView.textColor = UIColor.black
        
        
        guard let provider = YRTViewProvider(uiView: textView) else {
            return
        }
        let viewPlacemark = mapObjects.addPlacemark(
            with: YMKPoint(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude),
            view: provider);
            provider.snapshot()
            viewPlacemark.setViewWithView(provider)
        mapView.mapWindow.map.mapObjects.addPlacemark(with: YMKPoint(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude))
        setupButton()
    }
}

extension MapsViewController {
    
    func setupButton() {
        moveButton.frame = CGRect(x: mapView.bounds.width/2, y: mapView.bounds.height - 50, width: 80, height: 40)
        moveButton.setTitle(coordinate.name, for: .normal)
        moveButton.tintColor = .white
        moveButton.addTarget(self, action: #selector(noveActive), for: .touchUpInside)
        moveButton.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        mapView.addSubview(moveButton)
    }
    
    
    @objc func noveActive() {
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        mapView.mapWindow.map.move(with: .init(target: YMKPoint(), zoom: 40, azimuth: 0, tilt: 0)
        )
        moveMaps(to: location)
        moveButton.isHidden = true
    }
    
    
}
