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

    @IBAction func appendDigit(sender: UIButton) {
        // declare a constant variable
        let digit = sender.currentTitle
    }
}

