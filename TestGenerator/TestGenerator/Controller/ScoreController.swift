//
//  ScoreController.swift
//  TestGenerator
//
//  Created by vibin joby on 2019-11-09.
//  Copyright © 2019 vibin joby. All rights reserved.
//

import UIKit

protocol ScoreDelegate:class {
    func getScore() -> Int
}

class ScoreController: UIViewController {

    @IBOutlet weak var scoreLbl: UILabel!
    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var retakeQuizBtn: UIButton!
    
    weak var delegate:ScoreDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let score = delegate.getScore()
        scoreLbl.text! = "Your score is \(score)"
        
        if score < 3 {
            messageLbl.text! = "Please try again!"
            retakeQuizBtn.isHidden = false
        } else if score == 3 {
            messageLbl.text! = "Good job!"
        } else if score == 4 {
            messageLbl.text! = "Excellent work!"
        } else if score == 5 {
            messageLbl.text! = "You are a genius"
        }
        
    }

}
