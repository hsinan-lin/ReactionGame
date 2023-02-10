//
//  ViewController.swift
//  ReactionGame
//
//  Created by Lin Hsin-An on 2023/2/10.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timeCount: UILabel!
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var popupButton: UIButton!
    
    var counter = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Set up a timer (tie it to the function updateCounter)
        Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        
        // Hide popup letters
        popupButton.isHidden = true
        
    }
    
    @objc func updateCounter() {
        // Display time passed when game starts
        if newGameButton.isHidden && !popupButton.isHidden{
            timeCount.text = "\(counter/100)s" //String(format:"%.2fs", counter/100)
            counter += 1
        }else{
            counter = 0.0
        }
    }
    
    func changeLetter(){
        //choose a random letter
        let arr = Array(arrayLiteral: "軟", "體", "工", "程")
        let randomNum = Int.random(in: 0...arr.count-1)
        //popupButton.titleLabel?.text = arr[randomNum]
        popupButton.setTitle(arr[randomNum], for: .normal)
        
        //*change where the letter is positioned
        popupButton.frame.origin = CGPoint(
            x: Int.random(in: 0...200),
            y: Int.random(in: 100...600)
        )
        
        //*change letter size
        /*
        popupButton.frame.size = CGSize(
            width: Double.random(in: 20...200),
            height: Double.random(in: 20...200)
        )
        */
        popupButton.titleLabel?.font = UIFont(
            name: "Noto Sans Kannada",
            size: CGFloat.random(in: 5...75)
        )
        //popupButton.titleLabel?.font.withSize(CGFloat.random(in: 5...75))
        
        //change letter color
        popupButton.setTitleColor(UIColor(
            red: Double.random(in: 0...1),
            green: Double.random(in: 0...1),
            blue: Double.random(in: 0...1),
            alpha: Double.random(in: 0.5...1)), for: .normal
        )
        
        //*change letter angle
        
        //show the letter
        //popupButton.isHidden = false
        let delay = Double.random(in: 0...2)
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.popupButton.isHidden = false
        }
        
    }
    
    @IBAction func startGame(_ sender: UIButton) {
        newGameButton.isHidden = true
        changeLetter()
    }
    
    @IBAction func letterTapped(_ sender: UIButton) {
        popupButton.isHidden = true
        changeLetter()        
    }
    
    //Record best record
    
    @IBAction func restartGame(_ sender: UIButton) {
        newGameButton.isHidden = false
        popupButton.isHidden = true
        timeCount.text = "0s"
    }
}








