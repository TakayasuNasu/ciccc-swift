//
//  BackTracking.swift
//  AlgorithmDataStructure
//
//  Created by Takayasu Nasu on 2021/03/11.
//

import Foundation

func rollDiceSum(n: Int, desiredSum: Int) {
  var choices = [Int]()
  rollDiceSumHelper(n: n, desiredSum: desiredSum, soFar: 0, choices: &choices)
}

func rollDiceSumHelper(n: Int, desiredSum: Int, soFar: Int, choices: inout [Int]) {
  if n == 0 {
    if desiredSum == soFar {
      print(choices)
    }
  } else {
    for i in 1...6 {
      if soFar + i + (n - 1) * 1 <= desiredSum && desiredSum <= soFar + i + (n - 1) * 6 {
        choices.append(i)
        rollDiceSumHelper(n: n - 1, desiredSum: desiredSum, soFar: soFar + i, choices: &choices)
        choices.removeLast()
      }
    }
  }
}

func rollDiceSumNoDuplicate(n: Int, desiredSum: Int) {
  var choices = [Int]()
  rollDiceSumNoDuplicateHelper(n: n, desiredSum: desiredSum, soFar: 0, choices: &choices)
}

func rollDiceSumNoDuplicateHelper(n: Int, desiredSum: Int, soFar: Int, choices: inout [Int]) {
  if n == 0 {
    if desiredSum == soFar {
      print(choices)
    }
  } else {
    for i in 1...6 {
      if soFar + i + (n - 1) * 1 <= desiredSum && desiredSum <= soFar + i + (n - 1) * 6 {
        if !choices.contains(i) {
          choices.append(i)
          rollDiceSumNoDuplicateHelper(n: n - 1, desiredSum: desiredSum, soFar: soFar + i, choices: &choices)
          choices.removeLast()
        }
      }
    }
  }
}
