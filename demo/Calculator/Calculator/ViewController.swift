//
//  ViewController.swift
//  Calculator
//
//  Created by Jingxin on 10/29/15.
//  Copyright (c) 2015 NYU. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var isUserTypingANumber: Bool = false
    
    // our model in MVC
    var brain = CalculatorBrain()

    @IBAction func appendDigit(sender: UIButton) {
        // declare a constant variable
        let digit = sender.currentTitle!
        if isUserTypingANumber {
            display.text = display.text! + digit
        } else {
            display.text = digit
            isUserTypingANumber = true
        }
    } 
    
    @IBAction func operate(sender: UIButton) {
        if isUserTypingANumber {
            enter()
        }
        if let operation = sender.currentTitle {
            if let result = brain.performOperation(operation) {
                displayValue = result
            } else {
                displayValue = 0
            }
        }
    }

    @IBAction func enter() {
        isUserTypingANumber = false
        if let result = brain.pushOperand(displayValue) {
            displayValue = result
        } else {
            displayValue = 0
        }
    }
    
    // computed property
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            isUserTypingANumber = false
        }
    }

}

