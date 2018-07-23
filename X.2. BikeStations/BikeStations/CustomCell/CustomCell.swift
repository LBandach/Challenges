//
//  CustomCell.swift
//  BikeStations
//
//  Created by user on 11.07.2018.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var stationName: UILabel!
    @IBOutlet weak var stationAdress: UILabel!
    @IBOutlet weak var bikesAvalible: UILabel!
    @IBOutlet weak var racksAvalible: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
