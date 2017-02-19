//
//  ViewController.swift
//  Calculator
//
//  Created by Austin Balarin on 2/17/17.
//  Copyright © 2017 Stanford Projects. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var display: UILabel!
    
    private var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    private var userIsInTheMiddleOfTyping = false
    
    // Function for controlling number presses
    @IBAction private func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        let currentText = display!.text!
        
        if userIsInTheMiddleOfTyping {
            display.text = currentText + digit
        }
        else{
            display.text = digit
        }
        
        userIsInTheMiddleOfTyping = true
    }
    
    // Init the model
    private var model = CalculatorModel()
    
    var savedProgram: CalculatorModel.PropertyList?
    
    @IBAction private func saveProgram() {
        savedProgram = model.program
    }
    
    @IBAction func restoreProgram() {
        if savedProgram != nil{
            model.program = savedProgram!
            displayValue = model.result
        }
    }
    
    // Function for controlling math operations
    @IBAction private func operation(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            model.setOperand(operand: displayValue)
            userIsInTheMiddleOfTyping = false
        }
        if let mathmaticalSymbol = sender.currentTitle {
            model.performOperation(symbol: mathmaticalSymbol)
        }
        displayValue = model.result
    }


}

