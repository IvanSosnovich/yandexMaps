//
//  MainView.swift
//  YandexMaps
//
//  Created by MIkkyMouse on 22.08.2020.
//  Copyright © 2020 Ivan Sosnovich. All rights reserved.
//

import UIKit


protocol MainViewProtocol: class {
    
}

class MainView: UIViewController {
    
    private let assembler: MainVIewAssemblerProtocol = MainViewAssembler()
    var presenter: MainViewPresenterProtocol!
    
    @IBOutlet weak var mapsTable: UITableView!
    
    override func viewDidLoad() {
        assembler.assemble(with: self)
        navigationController?.navigationBar.isHidden = true
        setupTable()
    }
    
    
}


extension MainView: MainViewProtocol {
    
}
// MARK: - setup table MainView
extension MainView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.returnAdresBook().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell") as? MainTableViewCell
        cell?.setupCell(for: presenter.returnAdresBook()[indexPath.row])
        return cell!
    }
    
    func setupTable() {
        mapsTable.register(UINib(nibName: "MainTableViewCell", bundle: nil), forCellReuseIdentifier: "MainTableViewCell")
        mapsTable.delegate = self
        mapsTable.dataSource = self
        mapsTable.rowHeight = 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.showMap(with: presenter.returnAdresBook()[indexPath.row])
    }
    
}
