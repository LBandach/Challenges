//
//  ViewController.swift
//  BitcoinTicker
//
//  Created by Angela Yu on 23/01/2016.
//  Copyright © 2016 London App Brewery. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    
    let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    let symbolArray = ["$", "R$", "$", "¥", "€", "£", "$", "Rp", "₪", "₹", "¥", "$", "kr", "$", "zł", "lei", "₽", "kr", "$", "$", "R"]
    var rowSelected = ""
    var finalURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTCUSD"

    //Pre-setup IBOutlets
    @IBOutlet weak var bitcoinPriceLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    

    
    override func viewDidLoad() {
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
        
        super.viewDidLoad()
    }

    
    //TODO: Place your 3 UIPickerView delegate methods here
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        finalURL = baseURL + currencyArray[row]
        rowSelected = symbolArray[row]
        getBTCData(url: finalURL)
    }
    
    
    
    
    //MARK: - Networking
    /***************************************************************/
    
    func getBTCData(url: String) {
        
        Alamofire.request(url, method: .get)
            .responseJSON { response in
                if response.result.isSuccess {
                    
                    let BTCJson:JSON = JSON(response.result.value!)
                    print("Sucess! Got the BTC data")
                    self.updateCurrencyData(BTCJson)

                } else {
                    print("Error: \(String(describing: response.result.error))")
                    self.bitcoinPriceLabel.text = "Connection Issues"
                }
            }

    }
    
    //MARK: - JSON Parsing
    /***************************************************************/
    
    func updateCurrencyData(_ BTCJson : JSON) {
        
        if let BTCprice = BTCJson["last"].double {
            print(BTCprice)
            print(rowSelected)
            bitcoinPriceLabel.text = rowSelected + String(BTCprice)
        
        } else {
            bitcoinPriceLabel.text = "Prica unavalible"
            print("asd")
        }
        
    }
    




}

