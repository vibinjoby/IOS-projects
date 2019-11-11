//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by vibin joby on 2019-11-08.
//  Copyright © 2019 vibin joby. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CurrencyDelegate {
    @IBOutlet weak var targetImg: UIImageView!
    @IBOutlet weak var baseImg: UIImageView!
    @IBOutlet weak var baseTextBox: UITextField!
    @IBOutlet weak var targetTextBox: UITextField!
    var baseCurrency:String?
    var targetCurrency:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        baseCurrency = "CAD"
        targetCurrency = "INR"
    }
    /*
     temp = a;
     a = b;
     b = temp;
     */
    @IBAction func invertCurrency(_ sender: UIButton) {
        var tempImg:UIImage
        var tempCurrency:String
        tempImg = baseImg.image!
        baseImg.image! = targetImg.image!
        targetImg.image! = tempImg
        
        tempCurrency = baseCurrency!
        baseCurrency! = targetCurrency!
        targetCurrency! = tempCurrency
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "baseCurrency" {
            let controller = segue.destination as! CurrencyViewController
            controller.delegate = self
            //controller.
            
        } else if segue.identifier == "targetCurrency" {
            let controller = segue.destination as! CurrencyViewController
            controller.delegate = self
        }
    }
    
    func setBaseChangeCurrency(_ countryObj:CountryWiseCurrency){
        baseImg.image = UIImage(named: countryObj.flagImage)
        baseCurrency = countryObj.currency
    }
    
    func setTargetChangeCurrency(_ countryObj:CountryWiseCurrency){
        targetImg.image = UIImage(named: countryObj.flagImage)
        targetCurrency = countryObj.currency
    }
    
    func convertAndCalculateCurrency() {
        CurrencyCalculator().getCurrencyValue (completionHandler: {
            currency in
            DispatchQueue.main.async {
                if !self.baseTextBox.text!.isEmpty && Double(self.baseTextBox.text!) != nil && !self.baseTextBox.text!.elementsEqual("0"){
                    let textBoxVal = Double(self.baseTextBox.text!)!
                    self.targetTextBox.text! = String(format: "%g", textBoxVal * Double(currency)!)
                    print(self.targetTextBox.text!)
                }
            }
        },baseCurrency!,targetCurrency!)
    }

    
    @IBAction func textFieldDidBeginEditing(_ textField: UITextField) {
        if baseCurrency == targetCurrency {
            //show an alert popup
        } else if !textField.text!.isEmpty {
            convertAndCalculateCurrency()
        }
    }
    

}

