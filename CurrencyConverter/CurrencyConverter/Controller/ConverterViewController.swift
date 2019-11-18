//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by vibin joby on 2019-11-08.
//  Copyright © 2019 vibin joby. All rights reserved.
//
import Foundation
import UIKit
//TO-DO:
// e+ causing issue in the textbox
// target textbox on click updating wrong value
var apiResultObj:CurrencyApiResults?
var dataModel = [CountryDataModel]()
var flagImgModel = [FlagImageDataModel]()
var filteredData: [CountryDataModel]!
var filteredCountryArr = [String]()

class ConverterViewController: UIViewController, CurrencyDelegate, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    let apiHelper = ApiHelper()
    var historyObj = CurrencyHistory()
    @IBOutlet weak var conversionLbl: UILabel!
    @IBOutlet weak var targetImg: UIImageView!
    @IBOutlet weak var baseImg: UIImageView!
    @IBOutlet weak var baseTextBox: UITextField!
    @IBOutlet weak var targetTextBox: UITextField!
    @IBOutlet weak var lastUpdatedLbl: UILabel!
    var baseCurrency:String?
    var targetCurrency:String?
    @IBOutlet weak var targetCurrencyLbl: UILabel!
    @IBOutlet weak var baseCurrencyLbl: UILabel!
    @IBOutlet weak var historyTable: UITableView!
    @IBOutlet weak var ratesLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeVariables()
    }
    
    func initializeVariables() {
        baseCurrency = "CAD"
        targetCurrency = "INR"
        baseTextBox.text = "1"
        styleTextFields(baseTextBox)
        styleTextFields(targetTextBox)
        textFieldDidBeginEditing(baseTextBox)
        loadCurrencyValues()
        loadCurrencyHistory()
        lastUpdatedLbl.text! = apiHelper.getCurrentTime()
    }
    
    /*
     temp = a;
     a = b;
     b = temp;
     */
    @IBAction func invertCurrency() {
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
        loadCurrencyHistory()
    }
    
    func styleTextFields(_ textField:UITextField) {
        textField.layer.cornerRadius = 15.0
        textField.layer.borderWidth = 2.0
        textField.layer.borderColor = UIColor.red.cgColor
    }
    func loadCurrencyValues() {
        let apiManager = CurrencyApiManager()
        if dataModel.isEmpty {
            apiManager.getCurrencyValue(completionHandler: {
                completion in
                DispatchQueue.main.async {
                    apiResultObj = completion
                    let isFileLoaded = self.apiHelper.loadCountryWithImagesFromDisk(apiResultObj!)
                    filteredData = dataModel
                    if !isFileLoaded {
                        self.apiHelper.downloadImages()
                        _ = self.apiHelper.loadCountryWithImagesFromDisk(apiResultObj!)
                    }
                }
            })
        }
    }
    
    func loadCurrencyHistory() {
        let apiManager = CurrencyApiManager()
        let pastDate = Calendar.current.date(byAdding: .day, value: -3, to: Date())
        let yesterdaysDate = Calendar.current.date(byAdding: .day, value: -1, to: Date())
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        apiManager.getCurrencyHistory(self.baseCurrency!, self.targetCurrency!, format.string(from: pastDate!),format.string(from: yesterdaysDate!), completionHandler: {
            completion in
            DispatchQueue.main.async {
                self.historyObj = completion
                self.historyTable.reloadData()
            }
        })
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
    
    func setBaseChangeCurrency(_ countryObj:CountryDataModel){
        //Incase the base currency and target are same store the old currency in a temp variable before inverting
        let tempBaseCurrency = baseCurrency
        baseCurrency = countryObj.currencyId
        if baseCurrency == targetCurrency {
            baseCurrency = tempBaseCurrency
            invertCurrency()
        } else {
            let flagImgIndex = flagImgModel.firstIndex { (flagImgDataObj) -> Bool in
                return flagImgDataObj.currencyId == countryObj.alpha3
            }
            
            baseImg.image = flagImgModel[flagImgIndex!].flagImage
            baseCurrencyLbl.text = baseCurrency!
            //Call the text field begin editing method to update the text field value with the current currency values after changing the fields
            textFieldDidBeginEditing(baseTextBox)
        }
        loadCurrencyHistory()
        lastUpdatedLbl.text! = apiHelper.getCurrentTime()
        navigationController?.popViewController(animated: true)
    }
    
    func setTargetChangeCurrency(_ countryObj:CountryDataModel ){
        let tempTargetCurrency = targetCurrency
        targetCurrency = countryObj.currencyId
        if baseCurrency == targetCurrency {
            targetCurrency = tempTargetCurrency
            invertCurrency()
        } else {
            let flagImgIndex = flagImgModel.firstIndex { (flagImgDataObj) -> Bool in
                return flagImgDataObj.currencyId == countryObj.alpha3
            }
            targetImg.image = flagImgModel[flagImgIndex!].flagImage
            targetCurrencyLbl.text = targetCurrency!
            textFieldDidBeginEditing(targetTextBox)
        }
        loadCurrencyHistory()
        lastUpdatedLbl.text! = apiHelper.getCurrentTime()
        navigationController?.popViewController(animated: true)
    }
    
    func convertAndCalculateCurrencyBaseToTarget() {
        CurrencyApiManager().convertCurrency (baseCurrency!,targetCurrency!,completionHandler: {
            currency in
            DispatchQueue.main.async {
                
                if !self.baseTextBox.text!.isEmpty && Double(self.baseTextBox.text!) != nil && !self.baseTextBox.text!.elementsEqual("0") && Double(currency) != nil{
                    let textBoxVal = Double(self.baseTextBox.text!)!
                    self.setConversionLabel(currency,self.baseCurrency!,self.targetCurrency!)
                    self.targetTextBox.text! = String(format: "%g", textBoxVal * Double(currency)!)
                    print("target text box val is \(self.targetTextBox.text!)")
                }
            }
        })
    }
    
    func convertAndCalculateCurrencyTargetToBase() {
        CurrencyApiManager().convertCurrency (baseCurrency!,targetCurrency!,completionHandler: {
            currency in
            DispatchQueue.main.async {
                if !self.targetTextBox.text!.isEmpty && Double(self.targetTextBox.text!) != nil && !self.targetTextBox.text!.elementsEqual("0") && Double(currency) != nil{
                    let textBoxVal = Double(self.targetTextBox.text!)!
                    self.baseTextBox.text! = String(format: "%g", textBoxVal * Double(currency)!)
                    self.setConversionLabel(currency,self.baseCurrency!,self.targetCurrency!)
                }
            }
        })
    }
    
    
    @IBAction func xButtonAction(_ sender: UIButton) {
        baseTextBox.text! = "1"
        textFieldDidBeginEditing(baseTextBox)
    }
    @IBAction func textFieldDidBeginEditing(_ textField: UITextField) {
        if !textField.text!.isEmpty && Double(textField.text!) != nil{
            if textField == baseTextBox {
                convertAndCalculateCurrencyBaseToTarget()
            } else if textField == targetTextBox {
                convertAndCalculateCurrencyTargetToBase()
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var isBackSpacePressed = false
        //Check if a backspace is pressed
        if let char = string.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if (isBackSpace == -92) {
                isBackSpacePressed = true
            }
        }
        let oldText = textField.text!
        let stringRange = Range(range, in:oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        
        //If the backspace is not pressed only then check for multiple dots
        if !isBackSpacePressed && oldText.contains(".") && String(newText.last!) == "." {
            return false
        } else if Double(oldText) == nil && Double(newText) == nil {
            return false
        }
        
        return true
    }
    
    func setConversionLabel(_ outputValue:String,_ currencyName:String,_ targetCurrency:String) {
        conversionLbl.text! = "1 \(currencyName) EQUALS \(outputValue) \(targetCurrency)"
    }
    
    // MARK: - Table view data source functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyObj.historyDateWithRate != nil ? historyObj.historyDateWithRate!.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = historyTable.dequeueReusableCell(withIdentifier: "historyCell")
        let historyLbl = cell?.viewWithTag(1) as! UILabel
        var historyDate:String?
        var historyValue:Double?
        if historyObj.historyDateWithRate != nil {
            historyDate = Array<String>(historyObj.historyDateWithRate!.keys)[indexPath.row]
            historyValue = Array<Double>(historyObj.historyDateWithRate!.values)[indexPath.row]
        }
        let baseTargetCode = historyObj.currencyId!.split(separator: "_")
        let value = "\(String(format: "%g",historyValue!)) \(String(describing: baseTargetCode[1]))"
        historyLbl.text! = "\(String(describing: apiHelper.getCustomizedHistoryDates(historyDate!))) \(value)"
        ratesLbl.text! = "\(baseTargetCode[0]) / \(baseTargetCode[1]) Rates from last 3 days"
        return cell!
    }
    
}

