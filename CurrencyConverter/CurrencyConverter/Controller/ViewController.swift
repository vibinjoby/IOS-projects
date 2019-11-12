//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by vibin joby on 2019-11-08.
//  Copyright © 2019 vibin joby. All rights reserved.
//

import UIKit
//TO-DO:
// text box validations when allow only numbers and dots which is always less than 2

class ViewController: UIViewController, CurrencyDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var targetImg: UIImageView!
    @IBOutlet weak var baseImg: UIImageView!
    @IBOutlet weak var baseTextBox: UITextField!
    @IBOutlet weak var targetTextBox: UITextField!
    var baseCurrency:String?
    var targetCurrency:String?
    @IBOutlet weak var targetCurrencyLbl: UILabel!
    @IBOutlet weak var baseCurrencyLbl: UILabel!
    
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
        
        baseCurrencyLbl.text = baseCurrency!
        targetCurrencyLbl.text = targetCurrency!
        
        textFieldDidBeginEditing(baseTextBox)
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "baseCurrency" {
            let controller = segue.destination as! CurrencyViewController
            controller.delegate = self
            controller.isTargetCurrency = false
            
        } else if segue.identifier == "targetCurrency" {
            let controller = segue.destination as! CurrencyViewController
            controller.delegate = self
            controller.isTargetCurrency = true
        }
    }
    
    func setBaseChangeCurrency(_ countryObj:CountryWiseCurrency){
        //Incase the base currency and target are same store the old currency in a temp variable before inverting
        let tempBaseCurrency = baseCurrency
        baseCurrency = countryObj.currency
        if baseCurrency == targetCurrency {
            baseCurrency = tempBaseCurrency
            invertCurrency(UIButton())
        } else {
            baseImg.image = UIImage(named: countryObj.flagImage)
            baseCurrencyLbl.text = baseCurrency!
            //Call the text field begin editing method to update the text field value with the current currency values after changing the fields
            textFieldDidBeginEditing(baseTextBox)
        }
        navigationController?.popViewController(animated: true)
    }
    
    func setTargetChangeCurrency(_ countryObj:CountryWiseCurrency){
        let tempTargetCurrency = targetCurrency
        targetCurrency = countryObj.currency
        if baseCurrency == targetCurrency {
            targetCurrency = tempTargetCurrency
            invertCurrency(UIButton())
        } else {
            targetImg.image = UIImage(named: countryObj.flagImage)
            targetCurrencyLbl.text = targetCurrency!
            textFieldDidBeginEditing(targetTextBox)
        }
        navigationController?.popViewController(animated: true)
    }
    
    func convertAndCalculateCurrencyBaseToTarget() {
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
    
    func convertAndCalculateCurrencyTargetToBase() {
        CurrencyCalculator().getCurrencyValue (completionHandler: {
            currency in
            DispatchQueue.main.async {
                if !self.targetTextBox.text!.isEmpty && Double(self.targetTextBox.text!) != nil && !self.targetTextBox.text!.elementsEqual("0") && Double(currency) != nil{
                    let textBoxVal = Double(self.targetTextBox.text!)!
                    self.baseTextBox.text! = String(format: "%g", textBoxVal * Double(currency)!)
                    print(self.targetTextBox.text!)
                }
            }
        },targetCurrency!,baseCurrency!)
    }
    
    
    @IBAction func textFieldDidBeginEditing(_ textField: UITextField) {
        //Text box validations
        if !textField.text!.isEmpty {
            if textField.text! == "0" {
                textField.text = "1"
            }
        }
        if !textField.text!.isEmpty && Double(textField.text!) != nil{
            if textField == baseTextBox {
                convertAndCalculateCurrencyBaseToTarget()
            } else if textField == targetTextBox {
                convertAndCalculateCurrencyTargetToBase()
            }
        }
    }
}

