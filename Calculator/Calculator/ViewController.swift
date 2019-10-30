//
//  ViewController.swift
//  Calculator
//
//  Created by vibin joby on 2019-10-29.
//  Copyright © 2019 vibin joby. All rights reserved.
//

import UIKit

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
        //If the key pressed is not to clear the contents then proceed with the rest of the validations
        if sender.tag != 17 {
            // If the button pressed is only a number then append the inputs to the label
            if sender.tag < 12 {
                if !previousValue.isEmpty {
                    outputLabel.text = outputLabel.text! + String(sender.tag - 1)
                }
                else {
                    outputLabel.text = String(sender.tag - 1)
                    previousValue = outputLabel.text!
                }
            } else if sender.tag == 13 || sender.tag == 14 || sender.tag == 15 || sender.tag == 16{
                operationKey = sender.tag
                //Check if any operator is chosen again with more than 2 values then perform operation and proceed
                if isOperatorAlreadyPressed {
                    outputLabel.text! = outputLabel.text!.replacingOccurrences(of: "*", with: "").replacingOccurrences(of: "+", with: "").replacingOccurrences(of: "-", with: "").replacingOccurrences(of: "/", with: "")
                    previousValue = performOperation(Int(outputLabel.text!)!, Int(previousValue)!, previousOperationKey)
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
                // If the = button is pressed then perform the arithmetic operation on both the values
            } else if sender.tag == 12 {
                //While performing operation ignore the operators while converting the value from string to Int
                currentValue = outputLabel.text!.replacingOccurrences(of: "*", with: "").replacingOccurrences(of: "+", with: "").replacingOccurrences(of: "-", with: "").replacingOccurrences(of: "/", with: "")
                outputLabel.text = performOperation(Int(currentValue)!, Int(previousValue)!, operationKey)
                previousOperationKey = 0
                isOperatorAlreadyPressed = false
            }
            //If the button pressed is AC then clear the contents of the output label text and reset all the values to it's initial state
        } else {
            reset()
        }
    }
    
    
    func performOperation(_ currentVal:Int,_ previousVal:Int,_ operationKey:Int) -> String{
        var operationValue = 0
        //Addition
        if operationKey == 13 {
            operationValue = currentVal + previousVal
            operationLbl.text = "\(currentVal) + \(previousVal)"
            //Subtraction
        } else if operationKey == 14 {
            operationValue = previousVal - currentVal
            operationLbl.text = "\(previousVal) - \(currentVal)"
            //Multiplication
        } else if operationKey == 15 {
            operationValue = currentVal * previousVal
            operationLbl.text = "\(previousVal) * \(currentVal)"
            //Division
        } else if operationKey == 16 {
            operationValue = previousVal / currentVal
            operationLbl.text = "\(previousVal) / \(currentVal)"
        }
        
        return String(operationValue)
    }
    
    func getOperatorString(_ operationKey:Int) -> String{
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
    
    func reset() {
        outputLabel.text = "0"
        operationLbl.text = ""
        currentValue = ""
        previousValue = ""
        isOperatorAlreadyPressed = false
        previousOperationKey = 0
    }
    
    
}

