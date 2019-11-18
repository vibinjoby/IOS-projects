//
//  CustomTableView.swift
//  TableViewWithMultipleCells
//
//  Created by vibin joby on 2019-11-13.
//  Copyright © 2019 vibin joby. All rights reserved.
//

import UIKit

class QuestionTableViewCell: UITableViewCell {

    @IBOutlet weak var questionLbl: UILabel!
    
    func configureCell(_ questionStr:String) {
        questionLbl.text! = questionStr
    }

}
