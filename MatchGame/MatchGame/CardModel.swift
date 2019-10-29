//
//  CardModel.swift
//  MatchGame
//
//  Created by vibin joby on 2019-10-28.
//  Copyright © 2019 vibin joby. All rights reserved.
//

import Foundation

class CardModel {
    func generateCards() -> [Card]{
        var generatedCards = [Card]()
        
        for _ in 1...8 {
            
            let randomNumber = arc4random_uniform(13) + 1
            print(randomNumber)
            let cardOne = Card()
            cardOne.cardName = "card\(randomNumber)"
            generatedCards.append(cardOne)
            
            let cardTwo = Card()
            cardTwo.cardName = "card\(randomNumber)"
            generatedCards.append(cardTwo)
        }
        return generatedCards
    }
}
