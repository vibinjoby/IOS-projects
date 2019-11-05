//
//  ViewController.swift
//  Calculator
//
//  Created by vibin joby on 2019-10-29.
//  Copyright © 2019 vibin joby. All rights reserved.
//

import UIKit

//TO-DO :
// update plus minus in history functionality
//dont show operator symbol in the output label
// % modulus operator functionality

class ViewController: UIViewController {
    @IBOutlet weak var operationLbl: UILabel!
    @IBOutlet weak var outputLabel: UILabel!
    var previousValue:String = ""
    var currentValue:String = ""
    var operationKey = 0
    var previousOperationKey = 0
    var isOperatorAlreadyPressed = false
    static var historyArr:[String] = []
    var calculationHistory = ""
    
    override func viewDidLoad() {
        outputLabel.text = "0"
        operationLbl.text = ""
        super.viewDidLoad()
    }
    
    
    @IBAction func doOperation(_ sender: UIButton) {
        //If the previous output was an error then clear the screen for new operations
        if outputLabel.text!.elementsEqual("Error") {
            reset()
        }
        //If the key pressed is not to clear the contents then proceed with the rest of the validations
        if sender.tag != 17 {
            // If the button pressed is only a number then append the inputs to the label
            if sender.tag < 12 {
                //Functionality for '.' (Dots)
                if sender.tag == 11 {
                    //Prevent the '.' being used more than once
                    if !outputLabel.text!.contains(".") {
                        outputLabel.text! += "."
                    } else {
                        return
                    }
                    //If the previous value is not empty then append the values to the outputlabel
                } else if !previousValue.isEmpty {
                    outputLabel.text! += String(sender.tag - 1)
                    
                    //Else the previous value is initialised to the current number input from the calculator app
                } else {
                    outputLabel.text = String(sender.tag - 1)
                    previousValue = outputLabel.text!
                }
                //Append the dots to the operation label
                if sender.tag == 11 {
                    //When the operation label is initially empty and dot is pressed append zero at the front
                    if operationLbl.text!.isEmpty {
                        operationLbl.text! += "0"
                    }
                    operationLbl.text! += "."
                    //Append the inputs into the operation label dynamically
                } else {
                    operationLbl.text! += String(sender.tag - 1)
                }
                //Adding the output label to the calculation history
                if sender.tag != 11 {
                    calculationHistory += String(sender.tag - 1)
                } else {
                    calculationHistory += "."
                }
            } //+- operation functionality
            else if sender.tag == 18 && !outputLabel.text!.elementsEqual("0") {
                
                let decimalCharacters = CharacterSet.decimalDigits
                let decimalRange = outputLabel.text!.rangeOfCharacter(from: decimalCharacters)
                
                
                //Insert - only when the output label doesn't have a - sign already added
                if outputLabel.text!.hasPrefix("*") || outputLabel.text!.hasPrefix("/"){
                    //Check if there is a decimal number in the string
                    if decimalRange != nil {
                        //If the + sign exists then change it to - sign
                        if outputLabel.text!.firstIndex(of: "+") != nil {
                            outputLabel.text! = outputLabel.text!.replacingOccurrences(of: "+", with: "-")
                            operationLbl.text! = operationLbl.text!.replacingOccurrences(of: "+", with: "-")
                            //If the - sign exists then change it to + sign
                        } else if outputLabel.text!.firstIndex(of: "-") != nil {
                            outputLabel.text! = outputLabel.text!.replacingOccurrences(of: "-", with: "")
                            operationLbl.text! = operationLbl.text!.replacingOccurrences(of: "-", with: "")
                            //If no sign exists then change it to - sign
                        } else if outputLabel.text!.firstIndex(of: "-") == nil {
                            outputLabel.text!.insert("-", at: outputLabel.text!.index(outputLabel.text!.startIndex, offsetBy: 1))
                            operationLbl.text!.insert("-", at: operationLbl.text!.index(operationLbl.text!.lastIndex(of: "*")!, offsetBy: 1))
                        }
                    }
                    //If the number has a prefix of - sign then change it to + sign with the operation key
                } else if outputLabel.text!.hasPrefix("-")  {
                    //Change from - to +
                    operationKey = 13
                    outputLabel.text! = outputLabel.text!.replacingOccurrences(of: "-", with: "")
                    operationLbl.text! = operationLbl.text!.replacingOccurrences(of: "-", with: "")
                    //If the number has a prefix of + sign then change it to - sign with the operation key
                } else {
                    //Change from + to -
                    operationKey = 14
                    if outputLabel.text!.hasPrefix("+") {
                        outputLabel.text! = outputLabel.text!.replacingOccurrences(of: "+", with: "-")
                        operationLbl.text! = operationLbl.text!.replacingOccurrences(of: "+", with: "-")
                    } else {
                        outputLabel.text! = "-\(outputLabel.text!)"
                        operationLbl.text! = "-\(operationLbl.text!)"
                    }
                }
                
                // Check if the key pressed is any operator key from 13...16
            } else if sender.tag == 13 || sender.tag == 14 || sender.tag == 15 || sender.tag == 16{
                //If the output label ends with '.' and any mathematical operator is pressed append it with 0
                if outputLabel.text!.hasSuffix(".") {
                    outputLabel.text! += "0"
                }
                //If the operator key is pressed twice or more back to back do nothing
                if checkForDuplicateOperatorKey() {
                    return
                }
                
                //Get the operation key tag number
                operationKey = sender.tag
                
                //Check if any operator is chosen again with more than 2 values then perform operation and proceed
                if isOperatorAlreadyPressed {
                    //replacing the operator key to make sure the passed value to perform operation is a number
                    outputLabel.text! = outputLabel.text!.replacingOccurrences(of: "*", with: "").replacingOccurrences(of: "/", with: "")
                    previousValue = performOperation(outputLabel.text!, previousValue, previousOperationKey)
                    outputLabel.text = getOperatorString(operationKey)
                    operationLbl.text = previousValue
                    previousOperationKey = sender.tag
                } else {
                    //Append the output label to the previous value on click of operator sign
                    previousValue = outputLabel.text!
                    //Based on the sender tag of the operation key append the operator onto the output label
                    outputLabel.text = getOperatorString(operationKey)
                    //get the previous operation key loaded for the next operation
                    previousOperationKey = sender.tag
                    isOperatorAlreadyPressed = true
                }
                
                //Append the operator input into the operation label dynamically
                operationLbl.text! += getOperatorString(sender.tag)
                
                //Adding the output label to the calculation history
                calculationHistory += outputLabel.text!
                
                // If the = button is pressed then perform the arithmetic operation on both the values
            } else if sender.tag == 12 && (!outputLabel.text!.isEmpty && !outputLabel.text!.elementsEqual("0")){
                //If the output label ends with '.' and any mathematical operator is pressed append it with 0
                if outputLabel.text!.hasSuffix(".") {
                    outputLabel.text! += "0"
                }
                //Refrain the users from entering more than one operator at a time while calculating the output
                if checkForDuplicateOperatorKey() {
                    outputLabel.text = previousValue
                    return
                }
                //If the previous value is empty then do not perform any operation
                if previousValue.isEmpty {
                    return
                }
                //While performing operation ignore the operators while converting the value from string to Int
                currentValue = outputLabel.text!.replacingOccurrences(of: "*", with: "").replacingOccurrences(of: "/", with: "")
                //If divisible by 0 show error message
                if Int(currentValue) == 0 && operationKey == 16 {
                    outputLabel.text = "Error"
                    return
                }
                outputLabel.text = performOperation(currentValue, previousValue, operationKey)
                
                //Add the output to the history
                addToHistory()
                
                //After the equals is pressed reset the current value to zero and the previous value to the last output
                previousValue = outputLabel.text!
                currentValue = ""
                previousOperationKey = 0
                operationKey = 0
                operationLbl.text! = outputLabel.text!
                isOperatorAlreadyPressed = false
            } else {
                reset()
            }
            //If the button pressed is AC then clear the contents of the output label text and reset all the values to it's initial state
        } else {
            reset()
        }
    }
    
    //Action to perform on click of back space/ delete button
    @IBAction func backspaceAction(_ sender: UIButton) {
        var result = outputLabel.text!
        if !result.isEmpty {
            //If the result is not an error then proceed with the backspace functionality
            if result.count > 1 && !result.elementsEqual("Error"){
                //Remove the last index on click of the button
                result.remove(at: result.index(before: result.endIndex))
                outputLabel.text! = result
                operationLbl.text!.remove(at: operationLbl.text!.index(before: operationLbl.text!.endIndex))
                //Remove the last character from the history if the string is not empty
                if !calculationHistory.isEmpty {
                    calculationHistory.removeLast()
                }
            } else {
                //If the string is empty then reset the values to 0
                reset()
            }
        }
    }
    
    
    func performOperation(_ currentVal:String,_ previousVal:String,_ operationKey:Int) -> String{
        
        var finalOutput = ""
        var operationValueDouble = 0.0
        
        //Addition or Subtraction
        if operationKey == 13 || operationKey == 14{
            operationValueDouble = Double(currentVal)! + Double(previousVal)!
            operationLbl.text = "\(String(format: "%g", Double(previousVal)!)) + \(String(format: "%g", Double(currentVal)!))"
        //Multiplication
        } else if operationKey == 15 {
            operationValueDouble = Double(currentVal)! * Double(previousVal)!
            operationLbl.text = "\(String(format: "%g", Double(previousVal)!)) * \(String(format: "%g", Double(currentVal)!))"
        //Division
        } else if operationKey == 16 {
            operationValueDouble = Double(previousVal)! / Double(currentVal)!
            operationLbl.text = "\(String(format: "%g", Double(previousVal)!)) / \(String(format: "%g", Double(currentVal)!))"
        }
        
        //If the final output is XX.0 then remove the .0 from the final output
        finalOutput = String(format: "%g", operationValueDouble)
        
        return finalOutput
    }
    
    
    func checkForDuplicateOperatorKey() -> Bool {
        if outputLabel.text!.elementsEqual("*") || outputLabel.text!.elementsEqual("+") || outputLabel.text!.elementsEqual("/") || outputLabel.text!.elementsEqual("-") {
            return true
        }
        return false
    }
    
    func getOperatorString(_ operationKey:Int) -> String {
        var operatorStr = ""
        switch operationKey {
        case 13: operatorStr = "+"
        case 14: operatorStr = "-"
        case 15: operatorStr = "*"
        case 16: operatorStr = "/"
        default:
            operatorStr = ""
        }
        return operatorStr
    }
    
    //Adding the output label to the calculation history
    func addToHistory() {
        calculationHistory += " = \(outputLabel.text!)"
        ViewController.historyArr.append(calculationHistory)
        calculationHistory = outputLabel.text!
        print(ViewController.historyArr)
    }
    
    func reset() {
        outputLabel.text = "0"
        operationLbl.text = ""
        currentValue = ""
        previousValue = ""
        isOperatorAlreadyPressed = false
        previousOperationKey = 0
        calculationHistory = ""
    }
}

