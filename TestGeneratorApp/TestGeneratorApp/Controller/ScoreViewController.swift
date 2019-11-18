//
//  ScoreController.swift
//  TestGenerator
//
//  Created by vibin joby on 2019-11-09.
//  Copyright © 2019 vibin joby. All rights reserved.
//

import UIKit

protocol ScoreDelegate:class {
    func setScore() -> Int
}

class ScoreViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scoreLbl: UILabel!
    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var retakeQuizBtn: UIButton!
    
    weak var delegate:ScoreDelegate!
    
    override func viewDidLoad() {
        navigationItem.hidesBackButton = true
        super.viewDidLoad()
        let score = delegate?.setScore()
        scoreLbl.text! = "Your score is \(score!)"
        
        if score! < 3 {
            messageLbl.text! = "Please try again!"
            retakeQuizBtn.isHidden = false
            imageView.image  = UIImage.gifImageWithName(name: "failureGif")
        } else if score == 3 {
            messageLbl.text! = "Good job!"
            imageView.image  = UIImage.gifImageWithName(name: "goodworkGif")
        } else if score == 4 {
            messageLbl.text! = "Excellent work!"
            imageView.image  = UIImage.gifImageWithName(name: "excellentGif")
        } else if score == 5 {
            messageLbl.text! = "You are a genius"
            imageView.image  = UIImage.gifImageWithName(name: "clapImg")
        }
    }
    
    @IBAction func onClickRetakeQuiz() {
        self.performSegue(withIdentifier: "reloadTable", sender: self)
    }


}
