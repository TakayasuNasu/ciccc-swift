//
//  RollingDice.swift
//  TryAgainAssignment
//
//  Created by Takayasu Nasu on 2021/04/22.
//

import Foundation

func RollingDice() {

  func rollDiceSum(n: Int, desiredSum: Int) {
    let soFar = 0
    var choices: [Int] = []
    rollDiceSumHelper(n: n, desiredSum: desiredSum, soFar: soFar, choices: &choices)
  }

  func rollDiceSumHelper(n: Int, desiredSum: Int, soFar: Int, choices: inout [Int]) {
    print("n: \(n), soFar: \(soFar), choices: \(choices)")
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

  let input = readLine()!.split(separator: " ").map { Int($0)! }
  rollDiceSum(n: input[0], desiredSum: input[1])
}
