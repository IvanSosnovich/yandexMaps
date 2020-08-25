//
//  MainViewAssembler.swift
//  YandexMaps
//
//  Created by MIkkyMouse on 22.08.2020.
//  Copyright © 2020 Ivan Sosnovich. All rights reserved.
//

import UIKit

protocol MainVIewAssemblerProtocol: class {
    func assemble(with view: MainView)
}

class MainViewAssembler: MainVIewAssemblerProtocol {
    
    func assemble(with view: MainView) {
        
        let router = MainViewRouter(controller: view)
        let interactor = MainViewInteractor()
        
        let preseter = MainViewPresenter()
        preseter.router = router
        preseter.interactor = interactor
        preseter.view = view
        
        view.presenter = preseter
    }
}
