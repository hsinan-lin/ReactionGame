//
//  ViewController.swift
//  ReactionGame
//
//  Created by Lin Hsin-An on 2023/2/10.
//
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var instruction: UIStackView!
    @IBOutlet weak var timeCount: UILabel!
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var popupButton: UIButton!
    @IBOutlet weak var restartButton: UIButton!
    
    var counter = 0.0
    var worstTime = 0.0
    var bestTime = 1000000000.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Set up a timer (tie it to the function updateCounter)
        Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        
        // Hide the popup letter
        popupButton.isHidden = true
        
    }
    
    @objc func updateCounter() {
        // Display time passed when game starts
        if newGameButton.isHidden && !popupButton.isHidden{
            var timePassed = counter/100
            
            // Display time passed
            timeCount.text = "\(timePassed)s"
            
            counter += 1
        }else{
            // Make time count back to 0 when game restarts or when a letter is tapped
            counter = 0.0
        }
    }
    func recordTime(){
        //Store time records
        var timePassed = counter/100
        if timePassed > worstTime{
            worstTime = timePassed
        }
        if timePassed < bestTime && timePassed > 0{
            bestTime = timePassed
        }
    }
    
    func changeLetter(){
        //Generate a random letter to display
        ////  1. Create an array of English Alphabets
        let aScalars = "a".unicodeScalars
        let aCode = aScalars[aScalars.startIndex].value
        let letters: [Character] = (0..<26).map {
            i in Character(UnicodeScalar(aCode + i) ?? "a")
        }
        //// 2. Generate a random letter to display
        let randomNum = Int.random(in: 0...letters.count-1)
        let randomLetter = String(letters[randomNum])
        popupButton.setTitle(randomLetter, for: .normal)
        
        //Change where the letter is positioned
        //// 1. Get element coordinates and Set frame limit
        let letterFrame_x_left = 0.0
        let letterFrame_x_right = timeCount.frame.origin.x
        let letterFrame_y_top = instruction.frame.origin.y + 50
        let letterFrame_y_bottom = restartButton.frame.origin.y - restartButton.frame.size.height - 50
        //// 2. Set letter's coordinates randomly based on frame limit
        popupButton.frame.origin = CGPoint(
            x: CGFloat.random(in: letterFrame_x_left...letterFrame_x_right), //Int.random(in: 0...200),
            y: CGFloat.random(in: letterFrame_y_top...letterFrame_y_bottom) //Int.random(in: 100...600)
        )
        
        //Change letter size
        popupButton.titleLabel?.font = UIFont(
            name: "Noto Sans Kannada",
            size: CGFloat.random(in: 5...30)
        )
        
        //Change letter color
        popupButton.setTitleColor(UIColor(
            red: Double.random(in: 0...1),
            green: Double.random(in: 0...1),
            blue: Double.random(in: 0...1),
            alpha: Double.random(in: 0.2...0.6)), for: .normal
        )
        
        //Display the letter
        let delay = Double.random(in: 0...2)
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.popupButton.isHidden = false
        }
        
    }
    
    @IBAction func startGame(_ sender: UIButton) {
        // Hide "new game" button
        newGameButton.isHidden = true
        // Display a new letter
        changeLetter()
    }
    
    @IBAction func letterTapped(_ sender: UIButton) {
        // Hide the tapped letter
        popupButton.isHidden = true
        // Store records
        recordTime()
        // Display a new letter
        changeLetter()
    }
    
    @IBAction func restartGame(_ sender: UIButton) {
        // Hide the letter
        popupButton.isHidden = true
        
        // Announce records
        let recordAnnouncement = UIAlertController(
            title: "Your best and worst records are:",
            message: "Best record: \(bestTime)s \nWorst record: \(worstTime)s",
            preferredStyle: .alert)
        let okAction = UIAlertAction(
            title: "OK",
            style: .default,
            handler: nil)
        recordAnnouncement.addAction(okAction)
        present(recordAnnouncement, animated: true)
        
        // Show new game button
        newGameButton.isHidden = false
        
        
    }
}








