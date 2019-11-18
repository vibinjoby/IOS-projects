//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by vibin joby on 2019-11-17.
//  Copyright © 2019 vibin joby. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var baseLbl: UILabel!
    
    @IBOutlet weak var baseImgView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func onclick() {
        print("am getting clicked")
    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        self.performSegue(withIdentifier: "", sender: nil)
//        if segue.identifier == "baseCurrency" {
//            let controller = segue.destination as! CurrencyViewController
//            controller.delegate = self
//            controller.isTargetCurrency = false
//            
//        } else if segue.identifier == "targetCurrency" {
//            let controller = segue.destination as! CurrencyViewController
//            controller.delegate = self
//            controller.isTargetCurrency = true
//        }
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
