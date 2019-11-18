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
            qnsList!.append(Question("A baby blue whale drinks this many liters of milk per day:","190","50","10","500",1,0))
            qnsList!.append(Question("What airplane has not been flown commercially since 2003?","McDonnell Douglas MD80","Airbus 380","Boeing 747","Concorde",4,0))
            qnsList!.append(Question("Who invented the geodesic dome?","Samuel Fuller","Albert Einstein","R. Buckminster Fuller","Samuel Morse",3,0))
            qnsList!.append(Question("Indian cricket team captain","Rohit sharma","MS Dhoni","Virat kohli","Rahane",3,0))
            qnsList!.append(Question("Who invented the World Wide Web?","A laboratory in Switzerland","Microsoft","the Federal Communications Commission","Apple",1,0))
            
            qnsList!.append(Question("Which of the following technological developments came first?","teletype","telescope","telephone","telegraph",2,0))
            qnsList!.append(Question("When was the first plastic made of artificial materials patented?","1909","1945","1920","2003",1,0))
            qnsList!.append(Question("Saturn was named after the Roman god of what?","agriculture","children","fire","commerce",1,0))
            qnsList!.append(Question("What is the name of the U.S. spacecraft that visited Uranus in 1986?","Helios 1","Voyager 2","Galileo","Magellan",2,0))
            qnsList!.append(Question("The two most abundant elements in Jupiter’s atmosphere are hydrogen and what?","ammonia","nitrogen","helium","methane",3,0))
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
