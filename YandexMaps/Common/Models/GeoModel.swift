//
//  GeoModel.swift
//  YandexMaps
//
//  Created by MIkkyMouse on 24.08.2020.
//  Copyright © 2020 Ivan Sosnovich. All rights reserved.
//

import Foundation

class AddressBook {
    
    static let shared = AddressBook()
    private init () {}
    
    var adresGeo = [LocationAddressBook(name: "Go Jobs", latitude: 55.789536, longitude: 37.499162),
                    LocationAddressBook(name: "Go Friends", latitude: 59.925746, longitude: 32.320117),
                    LocationAddressBook(name: "Go Shops", latitude: 55.794217, longitude: 37.592608)
    ]
}

class LocationAddressBook {
    var name : String
    var latitude: Double
    var longitude: Double
    
    init(name: String, latitude: Double, longitude: Double) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
}
