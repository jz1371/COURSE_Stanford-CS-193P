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
        }
        display.text = display.text! + digit
        println("digit = \(digit)")
        
    }
}

