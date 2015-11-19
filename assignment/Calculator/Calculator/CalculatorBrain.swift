//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Jingxin on 11/18/15.
//  Copyright (c) 2015 NYU. All rights reserved.
//

import Foundation

class CalculatorBrain {
    
    private var opStack = [Op]()
    
    private var knownOps = [String : Op]()
    
    init() {
        func learnOp(op: Op) {
            knownOps[op.description] = op
        }
        learnOp(Op.BinaryOperation("+", +))
        learnOp(Op.BinaryOperation("−", { $1 - $0 }))
        learnOp(Op.BinaryOperation("×", *))
        learnOp(Op.BinaryOperation("÷", { $1 / $0 }))
        learnOp(Op.UnaryOperation("√", sqrt))
        learnOp(Op.UnaryOperation("sin", sin))
        learnOp(Op.UnaryOperation("cos", cos))
        learnOp(Op.UnaryOperation("π", { $0 * M_PI }))
    }
    
    func pushOperand(operand: Double) -> Double? {
        opStack.append(Op.Operand(operand))
        return evaluate()
    }
    
    func performOperation(symbol: String) -> Double? {
        if let operation = knownOps[symbol] {
            opStack.append(operation)
        }
        return evaluate()
    }
    
    private func evaluate(let ops: [Op]) -> (result: Double?, remainingOps: [Op]) {
        if (!ops.isEmpty) {
            var remainingOps = ops
            let op = remainingOps.removeLast()
            
            switch op {
                case .Operand(let operand):
                    return (operand, remainingOps)
                case .UnaryOperation(_, let operation):
                    let evaluation = evaluate(remainingOps)
                    if let operand = evaluation.result {
                        return (operation(operand), evaluation.remainingOps)
                    }
                case .BinaryOperation(_, let operation):
                    let evaluation1 = evaluate(remainingOps)
                    if let operand1 = evaluation1.result {
                        let evaluation2 = evaluate(evaluation1.remainingOps)
                        if let operand2 = evaluation2.result {
                            return (operation(operand1, operand2), evaluation2.remainingOps)
                        }
                    }
            }
        }
        return (nil, ops)
    }
    
    private func evaluate() -> Double? {
        let (result, remainder) = evaluate(opStack)
        println("\(opStack) = \(result) with \(remainder) left over")
        return result
    }
   
    private enum Op: Printable {
        case Operand(Double)
        case UnaryOperation(String, Double -> Double)
        case BinaryOperation(String, (Double, Double) -> Double)
        
        var description: String {
            get {
                switch self {
                case .Operand(let operand):
                    return "\(operand)"
                case .UnaryOperation(let symbol, _):
                    return "\(symbol)"
                case .BinaryOperation(let symbol, _):
                    return "\(symbol)"
                }
            }
        }
    }
    
    

}
