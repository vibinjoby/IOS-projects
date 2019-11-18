//
//  ViewController.swift
//  TableViewWithMultipleCells
//
//  Created by vibin joby on 2019-11-11.
//  Copyright © 2019 vibin joby. All rights reserved.
//

import UIKit
import SRCountdownTimer

//TO-DO:
// last question causes issue while clicking on next button


class ViewController: UIViewController, ScoreDelegate, UITableViewDataSource, UITableViewDelegate, SRCountdownTimerDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var countdownTimer: SRCountdownTimer!
    var quizQuestions = [Question]()
    var scorePts = 0
    var questionNumber = 0
    var timeLeft = 10
    var timer:Timer?
    
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var progressLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        initializeVariables()
        activateTimer()
        for questions in Questionaire().getRandomQuestions(maxNumber: 10,listSize: 5) {
            quizQuestions.append(questions)
        }
        loadCountDownTimer()
    }
    
    func setupNavigationBar() {
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.backgroundColor = UIColor.clear
    }
    
    func loadCountDownTimer() {
        countdownTimer.end()
        countdownTimer.delegate = self
        countdownTimer.labelFont = UIFont(name: "HelveticaNeue-Light", size: 50.0)
        countdownTimer.labelTextColor = UIColor.black
        countdownTimer.timerFinishingText = "Time Up"
        countdownTimer.lineWidth = 10
        countdownTimer.trailLineColor = UIColor.systemYellow
        countdownTimer.start(beginingValue: 10, interval: 1)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    var shownIndexes : [IndexPath] = []
    let CELL_HEIGHT : CGFloat = 40
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row > 0 {
            let addAnime = indexPath.row / 2
            cell.transform = CGAffineTransform(translationX: 0, y: CELL_HEIGHT)
            cell.layer.shadowColor = UIColor.black.cgColor
            cell.layer.shadowOffset = CGSize(width: 10, height: 10)
            cell.alpha = 0

            UIView.beginAnimations("rotation", context: nil)
            UIView.setAnimationDuration(0.5 + Double(addAnime))
            cell.transform = CGAffineTransform(translationX: 0, y: 0)
            cell.alpha = 1
            cell.layer.shadowOffset = CGSize(width: 0, height: 0)
            UIView.commitAnimations()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "questionCell") as? QuestionTableViewCell {
                cell.configureCell(quizQuestions[questionNumber].question)
                return cell
            }
        }
        if indexPath.row > 0{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "answerCell") as? AnswerTableViewCell {
                if indexPath.row == 1 {
                    cell.configureAnswerButtons(indexPath.row,quizQuestions[questionNumber].choiceA)
                } else if indexPath.row == 2 {
                    cell.configureAnswerButtons(indexPath.row,quizQuestions[questionNumber].choiceB)
                } else if indexPath.row == 3 {
                    cell.configureAnswerButtons(indexPath.row,quizQuestions[questionNumber].choiceC)
                } else if indexPath.row == 4 {
                    cell.configureAnswerButtons(indexPath.row,quizQuestions[questionNumber].choiceD)
                }
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    func updateNextQuestion() {
        if questionNumber < quizQuestions.count {
            progressLbl.text! = "\(questionNumber + 1)/5"
        }
        if questionNumber == 4 {
            nextBtn.setTitle("Submit", for: .normal)
        }
        tableView.reloadData()
    }
    
    @IBAction func nextQuestion() {
        resetBackgroundColor()
        if questionNumber != quizQuestions.count-1 {
            timeLeft = 10
            activateTimer()
            questionNumber += 1
            updateNextQuestion()
            loadCountDownTimer()
        } else {
            deactivateTimer()
            countdownTimer.end()
        }
    }
    
    func resetBackgroundColor() {
        let optionA = tableView.viewWithTag(1) as! UIButton
        let optionB = tableView.viewWithTag(2) as! UIButton
        let optionC = tableView.viewWithTag(3) as! UIButton
        let optionD = tableView.viewWithTag(4) as! UIButton
        
        optionA.backgroundColor = UIColor.systemYellow
        optionB.backgroundColor = UIColor.systemYellow
        optionC.backgroundColor = UIColor.systemYellow
        optionD.backgroundColor = UIColor.systemYellow
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
    
    
    @IBAction func returnToTableView(segue: UIStoryboardSegue) {
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.viewDidLoad()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showScore" {
            let controller = segue.destination as! ScoreViewController
            controller.delegate = self
            //reset the button variable to initial
            nextBtn.setTitle("Next", for: .normal)
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if nextBtn.titleLabel?.text != "Submit"  {
            return false
        }
        return true
    }
    
    func setScore() -> Int {
        for questions in quizQuestions {
            scorePts += questions.score
        }
        return scorePts
    }
    @objc func onTimerFires() {
        
        timeLeft -= 1
        if timeLeft <= 0 {
            deactivateTimer()
            loadCountDownTimer()
            nextQuestion()
        }
        
    }
    func timerDidEnd() {
       // if countForFinalQn == 6  {
           // performSegue(withIdentifier: "showScore", sender: nil)
       // }
        
    }
    
    func initializeVariables() {
        quizQuestions = []
        questionNumber = 0
        progressLbl.text! = "\(questionNumber + 1)/5"
        scorePts = 0
    }
    
    func activateTimer() {
        if timer != nil {
            timer?.invalidate()
        }
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
    }
    
    func deactivateTimer() {
        timer?.invalidate()
        timer = nil
    }
}

