//
//  Operand.swift
//  Calculator
//
//  Created by Daniil on 13.08.2021.
//

import Foundation
/*
 Новый тип данных для операндов
 Предназначен для упрощения изменения и отображения операндов;
 */
struct Operand
{
    var stringValue = ""
    var value: Decimal
    {
        get
        {
            return Decimal(string: stringValue)!
        }
        set
        {
            self.stringValue = "\(newValue)"
        }
    }
}
