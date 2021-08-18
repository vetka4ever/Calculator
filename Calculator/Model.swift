//
//  Model.swift
//  Calculator
//
//  Created by Daniil on 04.08.2021.
//

import Foundation

class Model
{
    /// Update operand
    /// - Parameters:
    ///   - operand: value of first of second operand
    ///   - newValue: that what should append to operand
    /// - Returns: updated operand
    func returnOneOperand(_ operand : Operand, _ newValue:String) -> Operand
    {
        var newOperand = operand
        newOperand.stringValue = (newOperand.stringValue == "0") ? newValue : newOperand.stringValue + newValue
        return newOperand
    }
    
    /// Helper func. Calling when was tap operation button, give understanding what should doing with operands & operation's character: change anyone or just return
    /// - Parameters:
    ///   - first: first operand
    ///   - second: first operand
    ///   - titleButton: character wich was tap last
    ///   - operation: current operation's character
    /// - Returns: updated or not operands & operation's character
    func returnOperation(_ first : Operand,_ second : Operand,  _ titleButton:String?, _ operation: String?) -> (Operand, Operand, String?)
    {
        var newFirst = first
        var newSecond = second
        var newOperation : String?
        {
            if first.stringValue == "" && second.stringValue == ""
            {
                return nil
            }
            return (titleButton == "=" || titleButton == "." || titleButton == "%") ? operation : titleButton
        }
        var newData: (Operand, Operand, String?) = (newFirst, newSecond, newOperation)
        switch titleButton
        {
        case "AC":
            newFirst = Operand()
            newSecond = Operand()
            newData = (newFirst,newSecond, nil)
        case "±":
            (second.stringValue == "") ? (newData.0 = changeOperandWithSpecialChar(&newFirst, "±")) : (newData.1 = changeOperandWithSpecialChar(&newSecond, "±"))
        case ".":
            (second.stringValue == "") ? (newData.0 = changeOperandWithSpecialChar(&newFirst, ".")) : (newData.1 = changeOperandWithSpecialChar(&newSecond, "."))
        case "%":
            (second.stringValue == "") ? (newData.0 = changeOperandWithSpecialChar(&newFirst, "%")) : (newData.1 = changeOperandWithSpecialChar(&newSecond, "%"))
        default:
            break
        }
        return newData
    }
    
    /// Change operand depending on character
    /// - Parameters:
    ///   - operand: value of first of second operand
    ///   - character: something character from button
    /// - Returns: changed operand
    private func changeOperandWithSpecialChar (_ operand: inout Operand, _ character: Character) -> Operand
    {
        switch character {
        case "±":
            (operand.stringValue.contains("-") == true) ? (operand.stringValue = "\(operand.value * -1)") : (operand.stringValue = "-" + operand.stringValue)
        case "%":
            operand.stringValue != "" ?(operand.value /= 100) : (operand.stringValue += "")
        case ".":
            (operand.stringValue.contains(".") == false) ? (operand.stringValue += ".") : (operand.stringValue += "")
        default:
            break
        }
        return operand
    }
    
    /// Calculate new value
    /// - Parameters:
    ///   - first: first operand
    ///   - second: second operand
    ///   - operation: current operation's character
    ///   - titleButton: character wich was tap last,
    /// - Returns: calculated value & operation's character
    func findNeedValue(_ first : Operand, _ second:  Operand, _ operation:String?, _ titleButton: String) -> (Operand, Operand, String?)
    {
        
        var res : (Operand, Operand, String?) = (first, .init(), (titleButton != "=" && titleButton != ".") ? titleButton : nil)
        switch operation {
        case "+":
            res.0.value = first.value + second.value
        case "-":
            res.0.value = first.value - second.value
        case "*":
            res.0.value = first.value * second.value
        case "/" where second.value != 0:
            res.0.value = first.value / second.value
        default:
            res.2 = nil
        }
        return res
    }
}
