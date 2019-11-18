//
//  AnswerTableViewCell.swift
//  TableViewWithMultipleCells
//
//  Created by vibin joby on 2019-11-13.
//  Copyright © 2019 vibin joby. All rights reserved.
//

import UIKit

class AnswerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var optionA: UIButton!
    @IBOutlet weak var optionB: UIButton!
    @IBOutlet weak var optionC: UIButton!
    @IBOutlet weak var optionD: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureAnswerButtons(_ row:Int, _ optionStr:String) {
        if row == 1 {
            optionA.setTitle(optionStr, for: .normal)
            optionA.tag = 1
        } else if row == 2 {
            optionB.setTitle(optionStr, for: .normal)
            optionA.tag = 2
        } else if row == 3 {
            optionC.setTitle(optionStr, for: .normal)
            optionA.tag = 3
        } else {
            optionD.setTitle(optionStr, for: .normal)
            optionA.tag = 4
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
