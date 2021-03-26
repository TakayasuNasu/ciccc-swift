//
//  CyclicPermutation.swift
//  AlgorithmDataStructure
//
//  Created by Takayasu Nasu on 2021/03/23.
//

import Foundation

func cyclicPermutation() {

  func dfs(vertex: Int, _ adjMatrix: inout [[Int]], _ stack: inout [Bool]) {
    stack[vertex] = true
    for (i,v) in adjMatrix[vertex].enumerated() {
      if v == 0 { continue }
      if stack[i] { continue }
      dfs(vertex: i, &adjMatrix, &stack)
    }
  }

  //  let n = readLine()!.split(separator: " ").map { Int($0)! }[0]
  //  let edge = readLine()!.split(separator: " ").map { Int($0)! }
  // [3, 2, 7, 8, 1, 4, 5, 6]
//  let n = 8
  let n = 10
//  let sample = [3, 2, 7, 8, 1, 4, 5, 6]
  let sample = [2, 1, 3, 4, 5, 6, 7, 9, 10, 8]
  var adjMatrix = [[Int]](repeating: [Int](repeating: 0, count: n), count: n)
  for (i, n) in sample.enumerated() {
    adjMatrix[i][n - 1] = 1
    adjMatrix[n - 1][i] = 1
  }

  for row in adjMatrix {
    print(row)
  }

  var stack = [Bool](repeating: false, count: n)
  var count = 0
  for row in 0..<n {
    if !stack[row] {
      dfs(vertex: row, &adjMatrix, &stack)
      count += 1
    }
  }
  print(count)
}

func repeatingSequence() {

  func squared(_ input: Int, _ stack: inout [Int]) {
    if input == 0 { return }
    let digit = input % 10
    squared(input / 10,  &stack)
    stack.append(digit * digit)
  }

  func backStack(_ answer: Int, _ answers: inout [Int], _ stack: inout [Int], _ finded: inout Int) {
    squared(answer, &stack)
    let newAnswer = stack.reduce(0, +)
    if answers.contains(newAnswer) {
      finded = newAnswer
      return
    }
    answers.append(newAnswer)
    stack.removeAll()
    backStack(newAnswer, &answers, &stack, &finded)
    if newAnswer == finded { print(answers.count)}
    answers.removeLast()
  }

  var stack: [Int] = []
  let answer = 12
  var answers: [Int] = []
  var finded: Int = -1
  backStack(answer, &answers, &stack, &finded)

}
