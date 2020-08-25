//
//  MainTableViewCell.swift
//  YandexMaps
//
//  Created by MIkkyMouse on 25.08.2020.
//  Copyright © 2020 Ivan Sosnovich. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    @IBOutlet weak var nameCell: UILabel!
    @IBOutlet weak var coordinate: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupCell(for item: LocationAdres) {
        nameCell.text = item.name
        coordinate.text = """
        Координаты:
        latitude: \(item.latitude)
        longitude: \(item.longitude)
        """
    }
    
}
