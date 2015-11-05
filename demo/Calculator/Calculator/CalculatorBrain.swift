//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Jingxin on 11/5/15.
//  Copyright (c) 2015 NYU. All rights reserved.
//

import Foundation

class CalculatorBrain {
    
    private enum Op: Printable { // implements Printable protocol
        case Operand(Double)
        case UnaryOperation(String, Double -> Double)
        case BinaryOperation(String, (Double, Double) -> Double)
        
        // required read-only computed property by Printable protocol
        var description: String {
            get {
                switch self {
                case .Operand(let operand):
                    return "\(operand)"
                case .UnaryOperation(let symbol, _):
                    return symbol
                case .BinaryOperation(let symbol, _):
                    return symbol
                }
            }
        }
    }
    

    /** private instances */
    private var opStack = [Op]()
    
    private var knownOps = [String : Op]()
    
    /** default constructor */
    init() {
        // inner function
        func learnOp(op: Op) {
            knownOps[op.description] = op
        }
        knownOps["÷"] = Op.BinaryOperation("÷") { $1 / $0 }
        knownOps["+"] = Op.BinaryOperation("+", +)
        knownOps["√"] = Op.UnaryOperation("√", sqrt)
        learnOp(Op.BinaryOperation("×", *))
        learnOp(Op.BinaryOperation("−", { $1 - $0 }))
    }
    
    /** public APIs */
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
    
    // ops is passed as a read-only and immutable array
    private func evaluate(let ops: [Op]) -> (result: Double?, remainingOps: [Op]) {
        if (!ops.isEmpty) {
            var remainingOps = ops
            let op = remainingOps.removeLast()
            
            switch op {
                case .Operand(let operand):
                    return (operand, remainingOps)
                case .UnaryOperation(_, let operation):
                    let operandEvaluation = evaluate(remainingOps)
                    if let operand = operandEvaluation.result {
                        return (operation(operand), operandEvaluation.remainingOps)
                    }
                case .BinaryOperation(_, let operation):
                    let op1Evaluation = evaluate(remainingOps)
                    if let operand1 = op1Evaluation.result {
                        let op2Evaluation = evaluate(op1Evaluation.remainingOps)
                        if let operand2 = op2Evaluation.result {
                            return (operation(operand1, operand2), op2Evaluation.remainingOps)
                        }
                    }
            }
            
        }
        return (nil, ops)
    }
    
    // return optional since operation might be illegal
    func evaluate() -> Double? {
        let (result, remainder) = evaluate(opStack)
        println("\(opStack) = \(result) with \(remainder) left over")
        return result
    }
    
}
