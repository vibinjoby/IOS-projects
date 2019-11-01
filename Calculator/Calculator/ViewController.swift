//
//  ViewController.swift
//  Calculator
//
//  Created by vibin joby on 2019-10-29.
//  Copyright © 2019 vibin joby. All rights reserved.
//

import UIKit

//TO-DO : 0. not working
// check the output label while performing arithmetic operation using .
extension String {
    var isInteger: Bool { return Int(self) != nil }
    var isFloat: Bool { return Float(self) != nil }
    var isDouble: Bool { return Double(self) != nil }
}

class ViewController: UIViewController {
    @IBOutlet weak var operationLbl: UILabel!
    @IBOutlet weak var outputLabel: UILabel!
    var previousValue:String = ""
    var currentValue:String = ""
    var operationKey = 0
    var previousOperationKey = 0
    var isOperatorAlreadyPressed = false
    
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
                    }
                    //If the previous value is not empty then append the values to the outputlabel
                } else if !previousValue.isEmpty {
                    outputLabel.text! += String(sender.tag - 1)
                } //Else the previous value is initialised to the current number input from the calculator app
                else {
                    outputLabel.text = String(sender.tag - 1)
                    previousValue = outputLabel.text!
                }
                //Append the dots to the operation label
                if sender.tag == 11 {
                    operationLbl.text! += "."
                    //Append the inputs into the operation label dynamically
                } else {
                    if !outputLabel.text!.contains(".") {
                        operationLbl.text! += String(sender.tag - 1)
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
                    outputLabel.text! = outputLabel.text!.replacingOccurrences(of: "*", with: "").replacingOccurrences(of: "+", with: "").replacingOccurrences(of: "-", with: "").replacingOccurrences(of: "/", with: "")
                    previousValue = performOperation(outputLabel.text!, previousValue, previousOperationKey)
                    outputLabel.text = getOperatorString(operationKey)
                    operationLbl.text = previousValue
                    previousOperationKey = sender.tag
                } else {
                    previousValue = outputLabel.text!
                    //Based on the sender tag of the operation key append the operator onto the output label
                    outputLabel.text = getOperatorString(operationKey)
                    previousOperationKey = sender.tag
                    isOperatorAlreadyPressed = true
                }
                
                //Append the operator input into the operation label dynamically
                operationLbl.text! += getOperatorString(sender.tag)
                
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
                currentValue = outputLabel.text!.replacingOccurrences(of: "*", with: "").replacingOccurrences(of: "+", with: "").replacingOccurrences(of: "-", with: "").replacingOccurrences(of: "/", with: "")
                //If divisible by 0 show error message
                if Int(currentValue) == 0 && operationKey == 16 {
                    outputLabel.text = "Error"
                    return
                }
                outputLabel.text = performOperation(currentValue, previousValue, operationKey)
                previousOperationKey = 0
                isOperatorAlreadyPressed = false
            }
            //If the button pressed is AC then clear the contents of the output label text and reset all the values to it's initial state
        } else {
            reset()
        }
    }
    
    @IBAction func backspaceAction(_ sender: UIButton) {
        var result = outputLabel.text!
        if !result.isEmpty {
            if result.count > 1 {
                result.remove(at: result.index(before: result.endIndex))
                outputLabel.text! = result
            } else {
                reset()
            }
        }
    }
    
    
    func performOperation(_ currentVal:String,_ previousVal:String,_ operationKey:Int) -> String{
        
        var finalOutput = ""
        var operationValueDouble = 0.0
        
        //Addition
        if operationKey == 13 {
            operationValueDouble = Double(currentVal)! + Double(previousVal)!
            operationLbl.text = "\(Double(currentVal)!) + \(Double(previousVal)!)"
        //Subtraction
        } else if operationKey == 14 {
            operationValueDouble = Double(previousVal)! - Double(currentVal)!
            operationLbl.text = "\(Double(previousVal)!) - \(Double(currentVal)!)"
        //Multiplication
        } else if operationKey == 15 {
            operationValueDouble = Double(currentVal)! * Double(previousVal)!
            operationLbl.text = "\(Double(currentVal)!) * \(Double(previousVal)!)"
        //Division
        } else if operationKey == 16 {
            operationValueDouble = Double(previousVal)! / Double(currentVal)!
            operationLbl.text = "\(Double(previousVal)!) / \(Double(currentVal)!)"
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
    
    func addToHistory() {
        
    }
    
    func reset() {
        outputLabel.text = "0"
        operationLbl.text = ""
        currentValue = ""
        previousValue = ""
        isOperatorAlreadyPressed = false
        previousOperationKey = 0
    }
}

