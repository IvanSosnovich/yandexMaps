//
//  MainViewPresenter.swift
//  YandexMaps
//
//  Created by MIkkyMouse on 22.08.2020.
//  Copyright © 2020 Ivan Sosnovich. All rights reserved.
//

import UIKit

protocol MainViewPresenterProtocol: class {
    func returnAdresBook() -> [LocationAdres]
    func showMap(with coordinate: LocationAdres)
}

class MainViewPresenter {
    
    weak var view: MainViewProtocol?
    var interactor: MainViewInteractorProtocol!
    var router: MainViewRouterProtocol!
    
}

extension MainViewPresenter: MainViewPresenterProtocol {
    
    
    func returnAdresBook() -> [LocationAdres] {
        return interactor.returnAdresBook()
    }
    
    func showMap(with coordinate: LocationAdres) {
        router.moveMap(with: coordinate)
    }
    
}
