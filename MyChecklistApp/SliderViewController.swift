//
//  AppDelegate.swift
//  MyChecklistApp
//
//  Created by Aaron Delgado on 15/03/16.
//  Copyright © 2016 Aarond. All rights reserved.
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
    var playerScoreStr = String()
    
    weak var selectedItem : ChecklistItem?
    
    
    //Optionals
    var targetValue: Int = 0
    var currentRound : Int = 0
    var randomNo : Int = 0
    var score : Int = 0
    
    @IBAction func hitmePressed(sender: AnyObject) {
        var currentValue : Int = Int(sliderGame.value)
        var difference = abs(targetValue - currentValue)
        var title: String
        //print("target \(targetValue) - currentval \(currentValue) ")
        if(difference == 0){
            title = "Perfect"
            score += 30
        } else if(difference < 5){
            title = "You almost had it"
            score += 15
        } else if(difference < 10){
            title = "Pretty good"
            score += 5
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
        currentRound += 1
        roundValue.text = String(currentRound)
        actionSheetController.addAction(okAction)
        self.presentViewController(actionSheetController, animated: true, completion: nil)
        
    }
    
    @IBAction func startOverPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func generateRandomNumber() -> Void{
        randomNo = 1 + Int(arc4random_uniform(100))
        randomNumber.text = "\(randomNo)"
        sliderGame.value = 50
        targetValue = randomNo
    }
    func  startNewRound() -> Void{
        
        generateRandomNumber()
    }
    func startNewGame() -> Void{
        roundValue.text = "0"
        generateRandomNumber()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //Catch the data from CheckListViewController
        playerName.text = playerLabel
        scoreValue.text = playerScoreStr
        roundValue.text = "0"
        generateRandomNumber()
    }
    override func viewWillAppear(animated: Bool) {
        selectedItem?.score = String(score)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
