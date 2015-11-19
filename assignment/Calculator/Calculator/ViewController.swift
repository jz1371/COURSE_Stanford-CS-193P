//
//  ViewController.swift
//  Calculator
//
//  Created by Jingxin on 11/5/15.
//  Copyright (c) 2015 NYU. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var isUserTyping = false
    
    private var brain = CalculatorBrain()

    @IBOutlet weak var displayLabel: UILabel!
    
    
    @IBAction func appendDigit(sender: UIButton) {
    }

}

