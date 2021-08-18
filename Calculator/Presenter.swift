//
//  Presenter.swift
//  Calculator
//
//  Created by Daniil on 04.08.2021.
//

import Foundation

class Presenter
{
    let model = Model()
    
    /// This func help me understand changed or not second operand after input character
    /// - Parameters:
    ///   - oldData: data before call return operation
    ///   - newData: data after call return operation
    /// - Returns: equatable oldData & newData or not
    private func secondOperandIsChanged(_ oldData: (Operand, Operand, String?), _ newData: (Operand, Operand, String?)) -> Bool
    {
        let aboutFirst = oldData.0.stringValue == newData.0.stringValue
        let aboutSecond = oldData.1.stringValue == newData.1.stringValue
        let aboutOperation = oldData.2 == newData.2
        return !(aboutFirst && aboutSecond && aboutOperation)
    }
    /// Find what need to do with operands && operation's character
    /// - Parameters:
    ///   - first: first operand
    ///   - second: first operand
    ///   - operation: current operation's character
    ///   - titleButton: character wich was tap last
    /// - Returns: updated values && operation's character
    func updateValues(_ first : Operand, _ second: Operand, _ operation:String?, _ titleButton: String) -> (Operand, Operand, String?)
    {
        let newData : (Operand, Operand, String?)
        if Double(titleButton) != nil
        {
            // doing input first or second operator
            let newOperand: Operand
            if operation == nil
            {
                newOperand = model.returnOneOperand(first, titleButton)
                newData = (newOperand, second, operation)
            }
            else
            {
                newOperand = model.returnOneOperand(second, titleButton)
                newData = (first, newOperand, operation)
            }
        }
        else
        {
            // doing operation over first, second or over them both
            let updatedData = model.returnOperation(first, second, titleButton, operation)
            if operation == nil || secondOperandIsChanged((first, second, operation), updatedData)
            {
                newData = updatedData
            }
            else
            {
                let result = model.findNeedValue(first, second, operation, titleButton)
                newData = result
            }
        }
        return newData
    }
}
