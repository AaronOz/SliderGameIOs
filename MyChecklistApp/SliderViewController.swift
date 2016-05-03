//
//  SliderViewController.swift
//  MyChecklistApp
//
//  Created by Aaron Delgado on 5/1/16.
//  Copyright © 2016 Martz. All rights reserved.
//

import UIKit

class SliderViewController: UIViewController {

    
    
    @IBOutlet var randomNumber: UILabel!
    @IBOutlet var playerName: UILabel!
    
    @IBOutlet var roundValue: UILabel!
    @IBOutlet var scoreValue: UILabel!
    @IBOutlet var sliderGame: UISlider!
    
    var playerLabel = String()
    var playerScore = Int()
    
    
    //Optionals
    var targetValue: Int = 0
    var currentRound : Int = 0
    var randomNo : Int = 0
    var score : Int = 0
    
    @IBAction func hitmePressed(sender: AnyObject) {
        var currentValue : Int = Int(sliderGame.value)
        var difference = abs(targetValue - currentValue)
        var title: String
        print("target \(targetValue) - currentval \(currentValue) ")
        if(difference == 0){
            title = "Perfect"
            score += 50
        } else if(difference < 5){
            title = "You almost had it"
            score += 39
        } else if(difference < 10){
            title = "Pretty good"
            score += 22
        }else{
            title = "Not even close"
        }
        let actionSheetController = UIAlertController(title: title, message: "Prepare for the next point", preferredStyle: .Alert)
        
        //Create and add the OK action
        let okAction = UIAlertAction(title: "Ok", style: .Cancel) { action -> Void in
            self.generateRandomNumber()
            let scoreString = String(self.score)
            
            if(self.score > self.playerScore){
             self.scoreValue.text = scoreString   
            }
        }
        actionSheetController.addAction(okAction)
        self.presentViewController(actionSheetController, animated: true, completion: nil)
        
        
    }
    
    @IBAction func startoverPressed(sender: AnyObject) {
        startNewGame()
    }
    
    
    func generateRandomNumber() -> Void{
        randomNo = 1 + Int(arc4random_uniform(100))
        randomNumber.text = "\(randomNo)"
        sliderGame.value = 50
        targetValue = randomNo
    }
    func  startNewRound() -> Void{
        currentRound += 1
        generateRandomNumber()
    }
    func startNewGame() -> Void{
        roundValue.text = "0"
        generateRandomNumber()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        playerName.text = playerLabel
        scoreValue.text = String(playerScore)
        roundValue.text = "0"
        generateRandomNumber()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ReturnList"{
            let ReturnViewController : ChecklistViewController = segue.destinationViewController as! ChecklistViewController
            if(score > playerScore){
                playerScore = score
            }
                ReturnViewController.playerScore = playerScore
            print("scored: \(score)")
            
            
            
        }
    }

}
