//
//  ViewController.swift
//  TestGenerator
//
//  Created by vibin joby on 2019-11-08.
//  Copyright © 2019 vibin joby. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController,ScoreDelegate {
    
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var progressLbl: UILabel!
    
    @IBOutlet weak var optionA: UIButton!
    @IBOutlet weak var optionB: UIButton!
    @IBOutlet weak var optionC: UIButton!
    @IBOutlet weak var optionD: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var questionLbl: UILabel!
    
    var quizQuestions = [Question]()
    
    var scorePts = 0
    
    var questionNumber:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        for questions in Questionaire().getRandomQuestions(maxNumber: 10,listSize: 5) {
            quizQuestions.append(questions)
            print("quiz questions getting appended with \(questions.question)")
        }
        updateNextQuestion()
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func updateNextQuestion() {
        if questionNumber < quizQuestions.count {
            progressView.frame.size.width = (view.frame.size.width / CGFloat(quizQuestions.count)) * CGFloat(questionNumber + 1)
            progressLbl.text! = "Progress \(questionNumber + 1)/5"
            
            questionLbl.text! = quizQuestions[questionNumber].question
            optionA.setTitle(quizQuestions[questionNumber].choiceA, for: .normal)
            optionB.setTitle(quizQuestions[questionNumber].choiceB, for: .normal)
            optionC.setTitle(quizQuestions[questionNumber].choiceC, for: .normal)
            optionD.setTitle(quizQuestions[questionNumber].choiceD, for: .normal)
        }
    }
    
    @IBAction func optionPressed(sender:UIButton) {
        resetBackgroundColor()
        if questionNumber < quizQuestions.count {
            if sender.tag == quizQuestions[questionNumber].correctAnswer {
                quizQuestions[questionNumber].score = 1
            } else {
                quizQuestions[questionNumber].score = 0
            }
            sender.backgroundColor = UIColor.green
        }
    }
    
    @IBAction func nextQuestion(_ sender: UIButton) {
        resetBackgroundColor()
        questionNumber += 1
        updateNextQuestion()
        if questionNumber == quizQuestions.count-1 {
            submitBtn.isHidden = false
            nextBtn.isHidden = true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "scoreShow" {
            let controller = segue.destination as! ScoreController
            controller.delegate = self
        }
    }
    
    func resetBackgroundColor() {
        optionA.backgroundColor = UIColor.systemYellow
        optionB.backgroundColor = UIColor.systemYellow
        optionC.backgroundColor = UIColor.systemYellow
        optionD.backgroundColor = UIColor.systemYellow
    }
    
    func getScore() -> Int {
        for questions in quizQuestions {
            scorePts += questions.score
        }
        return scorePts
    }
}

