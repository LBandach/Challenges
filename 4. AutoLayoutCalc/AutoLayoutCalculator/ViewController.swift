//
//  ViewController.swift
//  AutoLayoutCalculator
//
//  Created by user on 02.07.2018.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var numberOnTheScreen: Double = 0
    var rememberdNumber: Double = 0
    var mathOperation: String = ""
    var doingMath: Bool = false
    @IBOutlet weak var Label: UILabel!
    
    @IBAction func typingInNumbers (_ sender: UIButton) {
        
        if doingMath == false {
            if numberOnTheScreen == 0 {
                if sender.tag == 10 {
                    Label.text = "0"
                }else {
                    Label.text = String(sender.tag)
                }
            } else {
                if sender.tag == 10 {
                    Label.text = Label.text! + "0"
                }else {
                    Label.text = Label.text! + String(sender.tag)
                }
            }
            numberOnTheScreen = Double(Label.text!)!
            
        }else if doingMath == true {
    
            if sender.tag == 10 {
                    Label.text = "0"
                }else {
                    Label.text = String(sender.tag)
                }
            
            numberOnTheScreen = Double(Label.text!)!
            doingMath = false
        }
    }

    @IBAction func division(_ sender: UIButton) {
        rememberdNumber = numberOnTheScreen
        mathOperation = "÷"
        Label.text = mathOperation
        doingMath = true
    }
    
    @IBAction func multipication(_ sender: UIButton) {
        mathOperation = "*"
        Label.text = mathOperation
        doingMath = true
        rememberdNumber = numberOnTheScreen
    }
    
    @IBAction func addition(_ sender: UIButton) {
        mathOperation = "+"
        Label.text = mathOperation
        doingMath = true
        rememberdNumber = numberOnTheScreen
    }
    
    @IBAction func substraction(_ sender: UIButton) {
        mathOperation = "-"
        Label.text = mathOperation
        doingMath = true
        rememberdNumber = numberOnTheScreen
    }
    
    @IBAction func result(_ sender: UIButton) {
        numberOnTheScreen = makeCalculation(mathOperation)
        
        if (numberOnTheScreen - Double(Int(numberOnTheScreen))) == 0 {
            Label.text = String(format: "%.0f" , numberOnTheScreen)
        } else {
            Label.text = String(numberOnTheScreen)
        }
    }
    
    @IBAction func clear(_ sender: UIButton) {
        Label.text = "0"
        numberOnTheScreen = 0
        rememberdNumber = 0
    }
    
    @IBAction func changeMark(_ sender: UIButton) {
        numberOnTheScreen *= -1
        Label.text = String(numberOnTheScreen)
    }
    
    @IBAction func procentage(_ sender: UIButton) {
        numberOnTheScreen *= 0.01
        Label.text = String(numberOnTheScreen)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Label.text = "0"
   }

    func makeCalculation(_ mark: String) -> Double {
        if mark == "÷" {
            return (rememberdNumber / numberOnTheScreen)
        } else if mark == "*" {
            return (rememberdNumber * numberOnTheScreen)
        } else if mark == "+" {
            return (rememberdNumber + numberOnTheScreen)
        } else if mark == "-" {
            return (rememberdNumber - numberOnTheScreen)
        }
        return 0
    }
}

