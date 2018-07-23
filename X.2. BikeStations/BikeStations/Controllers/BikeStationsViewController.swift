//
//  ViewController.swift
//  BikeStations
//
//  Created by user on 11.07.2018.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit
import CoreLocation
import SwiftyJSON
import Alamofire

class BikeStationsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate, userGoBackDelegate {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let locationManager = CLLocationManager()
    let stationsURL = "http://www.poznan.pl/mim/plan/map_service.html?mtype=pub_transport&co=stacje_rowerowe"
    var passData: [String : String] = [:]
    var userParams: [String : Double] = [:]
    var stationParams: [String : Double] = [:]
    
    var stationsDataModel: [StationsDataModel.stations] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        getStationData(url: stationsURL)
        tableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "cell1")
        self.tableView.rowHeight = 80
    }

    
    //MARK: Networking
    
    func getStationData (url: String) {
        Alamofire.request(url, method: .get , parameters: nil).responseJSON {
            response in
            if response.result.isSuccess {
                print("Succes! I got station data")
                let stationJSON = JSON(response.result.value!)
                self.updateStationData(json: stationJSON)
            }
            else {
                print("Error \(String.init(describing: response.result.error))")
                self.titleLabel.text = "Couldn't recive data."
            }
        }
    }
    
    //MARK: JSON Parsing
    
    func updateStationData(json: JSON) {
        
        if json["features"][0]["geometry"]["coordinates"][0].double != nil{
            
            for i in 0...(json["features"].count - 1) {
                
                let station: StationsDataModel.stations = StationsDataModel.stations(coordinates: ["long" : json["features"][i]["geometry"]["coordinates"][0].double, "lat" : json["features"][i]["geometry"]["coordinates"][1].double] as! [String : Double], properties: ["stationName" : json["features"][i]["properties"]["label"].string, "freeRacks" : json["features"][i]["properties"]["free_racks"].string, "bikes" : json["features"][i]["properties"]["bikes"].string] as! [String : String])
                stationsDataModel.append(station)
                self.tableView.reloadData()
            }
            titleLabel.text = "Poznań bike stations:"
        }
    }
    
    //MARK : TabelView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stationsDataModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! CustomCell
        if stationsDataModel.count > 0 {
            cell.stationName.text = self.stationsDataModel[indexPath.item].properties["stationName"]!
            cell.stationAdress.text = ""//self.stationsDataModel[0].properties["stationAdress"]!
            cell.bikesAvalible.text = "bikes avalible: " + self.stationsDataModel[indexPath.item].properties["bikes"]!
            cell.racksAvalible.text = "racks avalible: " + self.stationsDataModel[indexPath.item].properties["freeRacks"]!
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        locationManager.startUpdatingLocation()
        passData = ["stationName" : self.stationsDataModel[indexPath.item].properties["stationName"] , "bikesAvalible" :  self.stationsDataModel[indexPath.item].properties["bikes"] , "racksAvalible" : self.stationsDataModel[indexPath.item].properties["freeRacks"]] as! [String : String]
        stationParams = ["longitude" : self.stationsDataModel[indexPath.item].coordinates["long"] ,"latitude" : self.stationsDataModel[indexPath.item].coordinates["lat"]] as! [String : Double]
        
        performSegue(withIdentifier: "goStationDetails", sender: Any?.self)
    }
    
    //MARK : LocationManager
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation] ) {
        let locations = locations[locations.count - 1]
        if locations.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            userParams = ["longitude" : locations.coordinate.longitude, "latitude" : locations.coordinate.latitude]
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error){
        print(error)
        titleLabel.text = "Couldn't recive GPS information"
    }
    
    //MARK : Perform Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goStationDetails"{
            let destinationVC = segue.destination as! StationDetailsViewController
            destinationVC.data = passData
            destinationVC.userParams = userParams
            destinationVC.stationParams = stationParams
            destinationVC.delegate = self
        }
    }
    
    func userMovedBack(stationName : String, distanceNumber : Double) {
        titleLabel.text = "Distance to \(stationName) is :\(Int(distanceNumber)) meters"
    }
    
}

