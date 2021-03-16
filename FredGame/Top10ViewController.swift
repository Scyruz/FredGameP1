//
//  Top10ViewController.swift
//  FredGame
//
//  Created by user188455 on 3/15/21.
//

import UIKit

class Top10ViewController: UIViewController {
    @IBOutlet weak var top1: UILabel!
    @IBOutlet weak var top2: UILabel!
    @IBOutlet weak var top3: UILabel!
    @IBOutlet weak var top4: UILabel!
    @IBOutlet weak var top5: UILabel!
    @IBOutlet weak var top6: UILabel!
    @IBOutlet weak var top7: UILabel!
    @IBOutlet weak var top8: UILabel!
    @IBOutlet weak var top9: UILabel!
    @IBOutlet weak var top10: UILabel!
    
    func configureView() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    var top10data : Top10? {
        didSet {
            // Update the view
        }
    }
}
