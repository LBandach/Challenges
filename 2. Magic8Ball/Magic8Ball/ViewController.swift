//
//  ViewController.swift
//  Magic8Ball
//
//  Created by user on 25.06.2018.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var magicBallImageView: UIImageView!
    
    let magicBallImageArray = ["ball1", "ball2", "ball3", "ball4" ,"ball5"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        magicBallImageChange()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func questionAskedButton(_ sender: UIButton) {
        
        magicBallImageChange()
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        
        magicBallImageChange()
    }
    
    func magicBallImageChange(){
        
        let magicBallRoll = arc4random_uniform(5)
        
        magicBallImageView.image = UIImage(named:  magicBallImageArray[Int(magicBallRoll)])
    }
    
    
}










