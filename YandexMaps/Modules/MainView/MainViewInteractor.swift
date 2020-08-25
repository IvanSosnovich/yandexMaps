//
//  MainViewInteractor.swift
//  YandexMaps
//
//  Created by MIkkyMouse on 22.08.2020.
//  Copyright © 2020 Ivan Sosnovich. All rights reserved.
//

import UIKit

protocol MainViewInteractorProtocol: class  {
    func returnAdresBook() -> [LocationAdres]
}

final class MainViewInteractor: MainViewInteractorProtocol {
    
    let adresBook = AdresModel.shared
    
    func returnAdresBook() -> [LocationAdres] {
        return adresBook.adresGeo
    }
    
}
