//
//  MainVIewRouter.swift
//  YandexMaps
//
//  Created by MIkkyMouse on 22.08.2020.
//  Copyright © 2020 Ivan Sosnovich. All rights reserved.
//

import UIKit
import CoreLocation

protocol MainViewRouterProtocol: class {
    func moveMap(with adres: LocationAddressBook)
}

class MainViewRouter: BaseRouter {
    
}

extension MainViewRouter: MainViewRouterProtocol {
    
    func moveMap(with coordinate: LocationAddressBook) {
        guard let vc = UIStoryboard(name: "MapsView", bundle: nil)
            .instantiateViewController(identifier: "MapsViewController") as? MapsViewController
        
            else {return}
        vc.coordinate = coordinate
        vc.modalPresentationStyle = .pageSheet
        self.show(vc)
        
    }
    
    
}
