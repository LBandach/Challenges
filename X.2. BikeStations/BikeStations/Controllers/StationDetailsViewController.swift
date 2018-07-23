//
//  StationDetailsViewController.swift
//  BikeStations
//
//  Created by user on 11.07.2018.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

protocol userGoBackDelegate {
    func userMovedBack(stationName : String, distanceNumber : Double)
}

class StationDetailsViewController: UIViewController {
    
    var data: [String : String] = [:]
    var delegate: userGoBackDelegate?
    var distanceNumber: Double = 0
    var userParams: [String : Double] = [:]
    var stationParams: [String : Double] = [:]

    @IBOutlet weak var stationName2Viem: UILabel!
    @IBOutlet weak var racksAvalible2View: UILabel!
    @IBOutlet weak var bikesAvalible: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    
    
    @IBAction func backTo1stVC(_ sender: UIButton) {
        delegate?.userMovedBack(stationName: stationName2Viem.text!, distanceNumber: distanceNumber)
        dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        calculateDistanceUserToStation(userParams, stationParams)
        stationName2Viem.text = data["stationName"]
        racksAvalible2View.text = "racks avalible: " + data["racksAvalible"]!
        bikesAvalible.text = "bikes avalible: " + data["bikesAvalible"]!
        distance.text = "You got \(Int(distanceNumber)) meters to station"
        
    }
    
    func calculateDistanceUserToStation (_ userParams: [String : Double], _ stationParams: [String : Double]) {
        
        distanceNumber = sqrt((pow((userParams["longitude"]! - stationParams["longitude"]!)*111320*0.6157,2) + (pow((userParams["latitude"]! - stationParams["latitude"]!)*11574, 2))))
        
    }

}
