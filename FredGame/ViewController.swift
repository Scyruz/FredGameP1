//
//  ViewController.swift
//  FredGame
//
//  Created by user188455 on 3/14/21.
//

import UIKit

class ViewController: UIViewController {
    // MARK: Variables
    let generator : SequenceGenerator = SequenceGenerator()
    let top10 : Top10 = Top10()
    var buttonsGrid : [UIButton?] = [UIButton?](repeating : nil, count: 10)
    var sequenceList : [Int] = []
    var pressedButtonCounter : Int = 0
    var score : Int64 = 0

    // MARK: Outlets
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    @IBOutlet weak var button9: UIButton!
    @IBOutlet weak var pendingCounter: UILabel!
    @IBOutlet weak var turnIndicator: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var highestScoresButton: UIButton!
    @IBOutlet weak var scoreCounter: UILabel!
    @IBOutlet weak var playButton: UIButton!
    
    
    // MARK: UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initializeButtonsGrid()
        status.text = "😴"
    
        
        
    }
  
    // MARK: Actions
    @IBAction func startGame(_ sender: UIButton) {
        status.text = "😴"
        playRound(roundNumber: 1)
        score = 0
        scoreCounter.text = "0"
        
        sender.isEnabled = false
        highestScoresButton.isEnabled = false
        
        button1.isEnabled = true
        button2.isEnabled = true
        button3.isEnabled = true
        button4.isEnabled = true
        button5.isEnabled = true
        button6.isEnabled = true
        button7.isEnabled = true
        button8.isEnabled = true
        button9.isEnabled = true
        
    }
    
    @IBAction func userResponse(_ sender: UIButton) {
        let pressedButtonIndex = buttonsGrid.firstIndex(of: sender)
        let currentPendingCounter = Int(self.pendingCounter.text!)
        let newPendingCounter = currentPendingCounter! - 1
        pendingCounter.text = String(newPendingCounter)
        
        button1.isEnabled = true
        button2.isEnabled = true
        button3.isEnabled = true
        button4.isEnabled = true
        button5.isEnabled = true
        button6.isEnabled = true
        button7.isEnabled = true
        button8.isEnabled = true
        button9.isEnabled = true
        
        sender.alpha = 1
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (nil) in
            sender.alpha = 0.5
        }
               
        if sequenceList[pressedButtonCounter] == pressedButtonIndex {
            score = score + Int64(pressedButtonCounter + 1) * 100
            scoreCounter.text = String(score)
            print(score)
            
            if pressedButtonCounter == sequenceList.count - 1 {
                pressedButtonCounter = 0
                
                Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { (nil) in
                    self.playRound(roundNumber: self.sequenceList.count + 1)
                }
            } else {
                pressedButtonCounter = pressedButtonCounter + 1
            }
        } else {
            pressedButtonCounter = 0
            status.text = "😱"
            
            pendingCounter.text = "0"
            top10.add(newScore: score)
            scoreCounter.text = "0"
            print(top10.top10List)
            
            playButton.isEnabled = true
            highestScoresButton.isEnabled = true
            
            button1.isEnabled = false
            button2.isEnabled = false
            button3.isEnabled = false
            button4.isEnabled = false
            button5.isEnabled = false
            button6.isEnabled = false
            button7.isEnabled = false
            button8.isEnabled = false
            button9.isEnabled = false
            
            let alert = UIAlertController(title: "GAME STATUS", message: "Game Over", preferredStyle: UIAlertController.Style.alert)
                              
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            present(alert, animated: true, completion: nil)
           
        }
        
        
    }
    
    // MARK: Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       // let controller = (segue.destination as! Top10ViewController)
//        controller.top1.text = String(top10.top10List[0])
//        controller.top2.text = String(top10.top10List[1])
//        controller.top3.text = String(top10.top10List[2])
//        controller.top4.text = String(top10.top10List[3])
//        controller.top5.text = String(top10.top10List[4])
//        controller.top6.text = String(top10.top10List[5])
//        controller.top7.text = String(top10.top10List[6])
//        controller.top8.text = String(top10.top10List[7])
//        controller.top9.text = String(top10.top10List[8])
//        controller.top10.text = String(top10.top10List[9])

    }
    
    // MARK: Game Methods
    func playRound(roundNumber : Int) {
        status.text = "🤔"
        sequenceList = generator.getSequenceList(size: roundNumber)
        turnIndicator.text = "Fred"
        pendingCounter.text = String(roundNumber)
        processSequenceButton(sequenceList : sequenceList, index : 0)
        
        button1.isEnabled = false
        button2.isEnabled = false
        button3.isEnabled = false
        button4.isEnabled = false
        button5.isEnabled = false
        button6.isEnabled = false
        button7.isEnabled = false
        button8.isEnabled = false
        button9.isEnabled = false
    }
    
    func processSequenceButton(sequenceList : [Int], index : Int) {
        let sequenceNumber : Int = sequenceList[index]
        let button : UIButton = buttonsGrid[sequenceNumber]!
        button.alpha = 1
       
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (nil) in
            button.alpha = 0.5
            let currentPendingCounter = Int(self.pendingCounter.text!)
            let newPendingCounter = currentPendingCounter! - 1
            self.pendingCounter.text = String(newPendingCounter)
            
            if index < sequenceList.count - 1 {
                self.processSequenceButton(sequenceList: sequenceList, index: index + 1)
            } else {
                self.turnIndicator.text = "You"
                self.pendingCounter.text = String(sequenceList.count)
                
                self.button1.isEnabled = true
                self.button2.isEnabled = true
                self.button3.isEnabled = true
                self.button4.isEnabled = true
                self.button5.isEnabled = true
                self.button6.isEnabled = true
                self.button7.isEnabled = true
                self.button8.isEnabled = true
                self.button9.isEnabled = true
            }
        }
    }
    
    // MARK: UI Methods
    func initializeButtonsGrid() {
        buttonsGrid.insert(button1, at: 1)
        buttonsGrid.insert(button2, at: 2)
        buttonsGrid.insert(button3, at: 3)
        buttonsGrid.insert(button4, at: 4)
        buttonsGrid.insert(button5, at: 5)
        buttonsGrid.insert(button6, at: 6)
        buttonsGrid.insert(button7, at: 7)
        buttonsGrid.insert(button8, at: 8)
        buttonsGrid.insert(button9, at: 9)
        
        button1.isEnabled = false
        button2.isEnabled = false
        button3.isEnabled = false
        button4.isEnabled = false
        button5.isEnabled = false
        button6.isEnabled = false
        button7.isEnabled = false
        button8.isEnabled = false
        button9.isEnabled = false

    }
}

