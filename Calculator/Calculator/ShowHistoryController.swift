//
//  ShowHistoryController.swift
//  Calculator
//
//  Created by vibin joby on 2019-11-03.
//  Copyright © 2019 vibin joby. All rights reserved.
//

import UIKit

class ShowHistoryController: UIViewController {
    @IBOutlet weak var operationLbl: UILabel!
    @IBOutlet weak var outputLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let vc = ViewController()
        if vc.operationLbl != nil {
            operationLbl.text = vc.operationLbl.text!
        }
        if vc.outputLabel != nil {
            outputLbl.text = vc.outputLabel.text
        }
    }
    
    @IBAction func close() {
      dismiss(animated: true, completion: nil)
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
