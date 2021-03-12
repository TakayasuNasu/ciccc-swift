//
//  RecursionAssignment1.swift
//  AlgorithmDataStructure
//
//  Created by Takayasu Nasu on 2021/03/09.
//

import Foundation

var numbers: [Int] = []
var operators: [Character] = []

func evaluate(_ expression: String) {
  if expression.count > 0 {
    let letter = expression.first!

    if ["+", "*"].contains(letter) {
      operators.append(letter)
    }

    if let number = Int(String(letter)) {
      numbers.append(number)
    }

    if letter == ")" {
      let operatorLetter = operators.popLast()
      let right = numbers.popLast()!
      let left = numbers.popLast()!
      if operatorLetter == "+" {
        let result = add(left, right)
        numbers.append(result)
      }
      if operatorLetter == "*" {
        let result = multiple(left, right)
        numbers.append(result)
      }
    }

    evaluate(expression[1, expression.count])
  } else {
    print(numbers[0])
    numbers.removeAll()
    operators.removeAll()
  }
}

func add(_ left: Int, _ right: Int) -> Int {
  return left + right
}

func multiple(_ left: Int, _ right: Int) -> Int {
  return left * right
}
