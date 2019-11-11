//
//  Question.swift
//  TestGenerator
//
//  Created by vibin joby on 2019-11-08.
//  Copyright © 2019 vibin joby. All rights reserved.
//

import Foundation

class Question: Hashable {
    
    var question:String
    var choiceA:String
    var choiceB:String
    var choiceC:String
    var choiceD:String
    var correctAnswer:Int
    var score:Int
    
    init(_ question:String,_ choiceA:String,_ choiceB:String,_ choiceC:String,_ choiceD:String,_ correctAnswer:Int,_ score:Int){
        self.question = question
        self.choiceA = choiceA
        self.choiceB = choiceB
        self.choiceC = choiceC
        self.choiceD = choiceD
        self.correctAnswer = correctAnswer
        self.score = score
    }
    
    func hash(into hasher:inout Hasher){
        
    }
    
    static func == (lhs: Question, rhs: Question) -> Bool {
        return lhs.question == rhs.question
    }
    
}
