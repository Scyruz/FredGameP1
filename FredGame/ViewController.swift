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
    
    // MARK: UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initializeButtonsGrid()

    }
  
    // MARK: Actions
    @IBAction func startGame(_ sender: UIButton) {
        status.text = "Playing"
        playRound(roundNumber: 1)
        score = 0
    }
    
    @IBAction func userResponse(_ sender: UIButton) {
        let pressedButtonIndex = buttonsGrid.firstIndex(of: sender)
        let currentPendingCounter = Int(self.pendingCounter.text!)
        let newPendingCounter = currentPendingCounter! - 1
        pendingCounter.text = String(newPendingCounter)
        
        sender.alpha = 1
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (nil) in
            sender.alpha = 0.5
        }
               
        if sequenceList[pressedButtonCounter] == pressedButtonIndex {
            score = score + Int64(pressedButtonCounter + 1) * 100
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
            status.text = "Finished"
            pendingCounter.text = "0"
            top10.add(newScore: score)
            print(top10.top10List)
        }
        
        
    }
    
    // MARK: Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    // MARK: Game Methods
    func playRound(roundNumber : Int) {
        sequenceList = generator.getSequenceList(size: roundNumber)
        turnIndicator.text = "Fred"
        pendingCounter.text = String(roundNumber)
        processSequenceButton(sequenceList : sequenceList, index : 0)
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
    }
}

