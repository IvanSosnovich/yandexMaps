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
    
    var coordinate: LocationAdres?
    let managerLocation = CLLocationManager()
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var moveButton: UIButton!
    
    
    @IBOutlet weak var mapView: YMKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        managerLocation.delegate = self
        managerLocation.startUpdatingLocation()
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = "\(coordinate!.name)"
        infoLabel.isHidden = true
        moveButton.isHidden = true
    }
    
    
    @IBAction func moveToLocation(_ sender: Any) {
        let location = CLLocation(latitude: coordinate!.latitude, longitude: coordinate!.longitude)
        moveButton.isHidden = true
        infoLabel.isHidden = true
        mapView.mapWindow.map.move(with: .init(target: YMKPoint(), zoom: 40, azimuth: 0, tilt: 0)
        )
        moveMaps(to: location)
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
            self.moveButton.setTitle("\(self.coordinate!.name)", for: .normal)
            self.moveButton.isHidden = false
            self.mapView.addSubview(self.moveButton)
            self.setupInfoView(with: location)
        }
    }
}

//MARK: - setup info label
extension MapsViewController {
    func setupInfoView(with location: CLLocation) {
        let geogoder = CLGeocoder()
        
        geogoder.reverseGeocodeLocation(location) { (placeMark, _) in
            var adresUser = ""
            guard let place = placeMark else {return}
            for placeUser in place {
                
                if placeUser.country != nil {
                    adresUser = placeUser.country!
                }
                
                if placeUser.subLocality != nil {
                    adresUser += ("\n \(placeUser.subLocality!)")
                }
                
                if placeUser.thoroughfare != nil {
                    adresUser += ("\n \(placeUser.thoroughfare!)")
                }
                
                if placeUser.subThoroughfare != nil {
                    adresUser += " \(placeUser.subThoroughfare!) "
                }
            }
            self.infoLabel.text = adresUser
            self.infoLabel.isHidden = false
            self.mapView.addSubview(self.infoLabel)
        }
    }
}
