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
        let operation = sender.currentTitle!
        if isUserTypingANumber {
            enter()
        }
        
        switch operation {
            // closure1
            case "×": performOperation({(op1: Double, op2: Double) -> Double in return op1 * op2})

            // neat closure
            case "÷": performOperation({ (op1, op2) in  op1 / op2})

            // function as argument
            case "+": performOperation(add)
            
            // positional arguments with closure
            case "−": performOperation { $1 - $0 }
            
            // function overloading
            case "√": performOperation { sqrt($0) }
            
            default: break
        }
    }
    
    private func performOperation(operation: (Double, Double) -> Double) {
        if (operandStack.count >= 2) {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    private func performOperation(operation: Double -> Double) {
        if (operandStack.count >= 1) {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
    func add(op1: Double, op2: Double) -> Double {
        return op1 + op2
    }
    
    // take advange of type infer instead of var operandStack: Array<Double> = Array<Double>()
    var operandStack = Array<Double>()

    @IBAction func enter() {
        isUserTypingANumber = false
        operandStack.append(displayValue)
        println("stack: = \(operandStack)")
    }
    
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

