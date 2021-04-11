//
//  Assignment.swift
//  AlgorithmDataStructure
//
//  Created by Takayasu Nasu on 2021/04/08.
//

import Foundation

func twoCityScheduling() {

  func twoCitySchedCost(_ costs: [[Int]]) -> Int {
    let sortedCosts = costs.sorted(by:{ (a,b) -> Bool in
      return a[1] - a[0] >  b[1] - b[0]
    })

    var totalCost = 0;
    let num = sortedCosts.count / 2

    for i in 0..<num {
      totalCost += sortedCosts[i][0]
      totalCost += sortedCosts[i + num][1]
    }

    return totalCost
  }

  // example input
  //  4
  //  10 20
  //  30 200
  //  400 50
  //  30 20
  let firstLine = Int(readLine()!)!
  var costs: [[Int]] = []

  for _ in 0..<firstLine {
    let edge = readLine()!.split(separator: " ").map { Int($0)! }
    costs.append(edge)
  }

  let result = twoCitySchedCost(costs)
  print(result)

}

func taskScheduler() {

  func leastInterval(_ tasks: [Character], _ n: Int) -> Int {
    var taskResources = [Character: Int]()
    for task in tasks {
      taskResources[task, default: 0] += 1
    }
    let maxResource = taskResources.values.max()!
    print(maxResource)
    let numsOfMax = taskResources.values.filter { $0 == maxResource }.count
    print(numsOfMax)
    return max(tasks.count, (maxResource - 1) * (n + 1) + numsOfMax)
  }

  // example input
  //  A A A B B B
  //  2
  let tasks = readLine()!.split(separator: " ").map { Character(String($0)) }
  let n = Int(readLine()!)!
  let result = leastInterval(tasks, n)
  print(result)
}


func gasStation() {

  func canCompleteCircuit(_ gas: [Int], _ cost: [Int]) -> Int {
    var total = 0
    var tank = 0
    var index = 0
    var startIndex = 0

    while index < gas.count {
      let remaining = gas[index] - cost[index]
      total += remaining
      if total < 0 {
        tank += total
        total = 0
        startIndex = index + 1
      }
      index += 1
    }

    if total + tank < 0 {
      return -1
    } else {
      return startIndex
    }
  }

  // example input
  //  1 2 3 4 5
  //  3 4 5 1 2
  let gas = readLine()!.split(separator: " ").map { Int($0)! }
  let cost = readLine()!.split(separator: " ").map { Int($0)! }
  let result = canCompleteCircuit(gas, cost)
  print(result)
}


func partitionLabels() {

  func partitionLabels(_ S: String) -> [Int] {
    let letterList = Array(S)
    var lastIndex = [Character: Int]()

    for (i, letter) in S.enumerated() {
      lastIndex[letter] = i
    }

    var start = 0
    var end = 0
    var answer = [Int]()

    while start < letterList.count {
      end = lastIndex[letterList[start]]!
      var begin = start
      while begin < end {
        let finish = lastIndex[letterList[begin]]!
        if finish > end {
          end = finish
        }
        begin += 1
      }
      answer.append(end - start + 1)
      start = end + 1
    }

    return answer
  }

  // example input
  // ababcbacadefegdehijhklij
  let S = readLine()!
  let result = partitionLabels(S)
  print(result)
}

func courseScheduleThird() {

  func scheduleCourse(_ courses: [[Int]]) -> Int {
    return 0
  }
}
