//
//  ViewController.swift
//  MatchGame
//
//  Created by vibin joby on 2019-10-28.
//  Copyright © 2019 vibin joby. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    var model = CardModel()
    var cards = [Card]()
    override func viewDidLoad() {
        super.viewDidLoad()
        cards = model.generateCards()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCollectionViewCell
        
        let card = cards[indexPath.row]
        
        cell.setCard(card)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
        
        let cardSelected = cards[indexPath.row]
        if (!cardSelected.isFlipped) {
            cell.flip()
            cardSelected.isFlipped = true
            
        } else {
            cell.flipBack()
            cardSelected.isFlipped = false
        }
    }
    
}

