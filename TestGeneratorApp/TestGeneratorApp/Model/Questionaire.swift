//
//  Questionaire.swift
//  TestGenerator
//
//  Created by vibin joby on 2019-11-08.
//  Copyright © 2019 vibin joby. All rights reserved.
//

import Foundation

class Questionaire {
    var qnsList:[Question]?
    
    init() {
        let utils = Utilities()
        qnsList = utils.loadQuestionsObject() != nil ? utils.loadQuestionsObject()! : nil
        
        if qnsList == nil {
            //use the hardcoded values
            qnsList = []
            qnsList!.append(Question("Capital of India","Karnataka","New Delhi","Chennai","kerala",2,0))
            qnsList!.append(Question("Prime Minister of India","Vajpayee","Narendra modi","Arvind Kejriwal","Amit shah",2,0))
            qnsList!.append(Question("God's own country","Kerala","Bangalore","Chennai","Tamilnadu",1,0))
            qnsList!.append(Question("Indian cricket team captain","Rohit sharma","MS Dhoni","Virat kohli","Rahane",3,0))
            qnsList!.append(Question("Ruling party in the centre","AAP","Congress","TMC","BJP",4,0))
            
            qnsList!.append(Question("National Bird of India","Crow","Penguin","Peacock","Love birds",3,0))
            qnsList!.append(Question("Which of the following is a union territory in India","Pondicherry","Chennai","Kerala","Trivandrum",1,0))
            qnsList!.append(Question("Who on the cricket world cup 2019","India","Australia","New Zealand","England",4,0))
            qnsList!.append(Question("What is 5 + 5 ?","12","10","13","14",2,0))
            qnsList!.append(Question("Who is the finance minister of india","Amit shah","Modi","Nirmala sitharaman","Tamilisai",3,0))
            //And save the values to the device
            utils.saveQuestionsObject(qnsList!)
        }
    }
    
    func getRandomQuestions(maxNumber: Int, listSize: Int)-> Set<Question> {
        var randomQuestions = Set<Question>()
        while randomQuestions.count < listSize {
            let randomNumber = Int(arc4random_uniform(UInt32(maxNumber+1)))
            if randomNumber >= 0 && randomNumber < 10 {
                randomQuestions.insert(qnsList![randomNumber])
            }
        }
        return randomQuestions
    }
}
