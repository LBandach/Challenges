//
//  ViewController.swift
//  Calculator
//
//  Created by user on 23.07.2018.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var numberOnScreen: Double = 0;
    var rememberdNumber: Double = 0;
    var performingMath = false;
    var operation = 0;
    var dotNumber = false;
    
    @IBOutlet weak var label: UILabel!
    
    @IBAction func numbers(_ sender: UIButton) {
        
        let array: [Int]? = nil
        
        for _ in array ?? [] {
            
        }
        
        if performingMath == true
        {
            label.text = String(sender.tag - 1)
            performingMath = false
            numberOnScreen = Double(label.text ?? "") ?? 0
        }
        else
        {
            label.text = label.text! + String(sender.tag - 1)
            numberOnScreen = Double(label.text!)!
        }
    }
    
    @IBAction func operations(_ sender: UIButton)
    {
        if sender.tag != 15 && sender.tag != 16 && label.text != "" && performingMath == false {
            
            rememberdNumber = Double(label.text!)!
            
            if sender.tag == 11 { // divide
                label.text = "/"
            }
            else if sender.tag == 12 { // multiply
                label.text = "*"
            }
            else if sender.tag == 13 { // substract
                label.text = "-"
            }
            else if sender.tag == 14 { // add
                label.text = "+"
            }
            operation = sender.tag
            performingMath = true
            dotNumber = false
        }
            
        else if sender.tag == 15 // equal
            
        {
            dotNumber = true
            
            if operation == 11
            {
                label.text = String(rememberdNumber / numberOnScreen)
                
                
                if  (rememberdNumber / numberOnScreen).truncatingRemainder(dividingBy:1) == 0
                {
                    label.text = String(rememberdNumber / numberOnScreen)
                    let range = label.text?.index((label.text?.endIndex)!, offsetBy: -2)
                    label.text = label.text!.substring(to: range!)
                    dotNumber = false
                }
                numberOnScreen = rememberdNumber / numberOnScreen
                
            }
            else if operation == 12
            {
                label.text = String(rememberdNumber * numberOnScreen)
                
                if  (rememberdNumber * numberOnScreen).truncatingRemainder(dividingBy:1) == 0
                {
                    label.text = String(rememberdNumber * numberOnScreen)
                    let range = label.text?.index((label.text?.endIndex)!, offsetBy: -2)
                    label.text = label.text!.substring(to: range!)
                    dotNumber = false
                }
                numberOnScreen = rememberdNumber * numberOnScreen
                
            }
            else if operation == 13
            {
                label.text = String(rememberdNumber - numberOnScreen)
                
                if  (rememberdNumber - numberOnScreen).truncatingRemainder(dividingBy:1) == 0
                {
                    label.text = String(rememberdNumber - numberOnScreen)
                    let range = label.text?.index((label.text?.endIndex)!, offsetBy: -2)
                    label.text = label.text!.substring(to: range!)
                    dotNumber = false
                }
                numberOnScreen = rememberdNumber - numberOnScreen
                
            }
            else if operation == 14
            {
                label.text = String(rememberdNumber + numberOnScreen)
                
                if  (rememberdNumber + numberOnScreen).truncatingRemainder(dividingBy:1) == 0
                {
                    label.text = String(rememberdNumber + numberOnScreen)
                    let range = label.text?.index((label.text?.endIndex)!, offsetBy: -2)
                    label.text = label.text!.substring(to: range!)
                    dotNumber = false
                }
                numberOnScreen = rememberdNumber + numberOnScreen
                
            }
            
        }
            
        else if sender.tag == 16 // clear
        {
            label.text = ""
            numberOnScreen = 0
            rememberdNumber = 0
            performingMath = false
            dotNumber = false
        }
    }
    
    @IBAction func otherButtons(_ sender: UIButton) {
        
        if sender.tag == 18 //18 plus minus
        {
            
            numberOnScreen = numberOnScreen * -1
            label.text = String(numberOnScreen)
            
            if  numberOnScreen.truncatingRemainder(dividingBy:1) == 0
            {
                label.text = String(numberOnScreen)
                let range = label.text?.index((label.text?.endIndex)!, offsetBy: -2)
                label.text = label.text!.substring(to: range!)
                dotNumber = false
            }
            
        }
            
        else if sender.tag == 19 //19 removing
        {
            
            label.text = String((label.text?.characters.dropLast())!)
            //label.text = label.text?.substring(to: (label.text?.index(before: (label.text?.endIndex)!))!)
            //label.text = label.text?.removeLast(1)//(at: label.text?(before: label.text?.endIndex))
        }
    }
    
    
    @IBAction func dot(_ sender: UIButton) //dot
    {
        if dotNumber == false {
            
            dotNumber = true
            label.text = label.text! + "."
        }
    }
    
    
    
}

