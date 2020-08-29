//
//  MainViewInteractor.swift
//  YandexMaps
//
//  Created by MIkkyMouse on 22.08.2020.
//  Copyright © 2020 Ivan Sosnovich. All rights reserved.
//

import UIKit

protocol MainViewInteractorProtocol: class  {
    func returnAdresBook() -> [LocationAddressBook]
}

final class MainViewInteractor: MainViewInteractorProtocol {
    
    let adresBook = AddressBook.shared
    
    func returnAdresBook() -> [LocationAddressBook] {
        return adresBook.adresGeo
    }
    
}
