//
//  ProblemSet.swift
//  AlgorithmDataStructure
//
//  Created by Takayasu Nasu on 2021/04/19.
//

import Foundation

func ClimbingStairs() {

  func climbStairs(_ n: Int) -> Int {
    var memo = [Int: Int]()
    return climbStairs(n, &memo)
  }

  func climbStairs(_ n: Int, _ memo: inout [Int: Int]) -> Int {
    if n <= 1 { return 1 }
    if memo[n] != nil {  return memo[n]! }

    memo[n] = climbStairs(n-1, &memo) + climbStairs(n-2, &memo) + climbStairs(n-3, &memo)
    return memo[n]!
  }

  let input = Int(readLine()!)!
  let result = climbStairs(input)
  print(result)
}

func MakeOne() {

  func makeOne(_ input: Int, _ count: inout Int) {
    if input == 1 {
      return
    }
    let n: Int = {
      if input % 3 == 2 && input % 2 == 0 {
        return input / 2
      } else if input % 3 == 1 {
        return input - 1
      } else {
        return input / 3
      }
    }()
    count += 1
    makeOne(n, &count)

  }

  let input = Int(readLine()!)!
  var count = 0
  makeOne(input, &count)
  print(count)
}

func PrettyNumber() {

  func prettyNumber(_ n: Int) {
    var d = [[Int]](repeating: [Int](repeating: 0, count: 10), count: 101)
    for i in 1...9 {
      d[1][i] = 1
    }

    for i in 2...n {
      for j in 0...9 {
        d[i][j] = 0
        if j >= 1 {

        }
        if j <= 8 {

        }
      }
    }
  }

  let input = Int(readLine()!)!
  prettyNumber(input)
}

func MaxSubArray() {

  func maxSubArray(_ nums: [Int]) -> Int {
    var m = 0
    var result = Int.min
    for i in 0..<nums.count {
      m = max(nums[i], nums[i] + m)
      result = max(result, m)
    }

    return result
  }

  let input = readLine()!.split(separator: " ").map { Int($0)! }
  let result = maxSubArray(input)
  print(result)
}

func CombinationSum() {

  func combinationSum(_ candidates: [Int], _ target: Int) -> [[Int]] {
    let n = candidates.count
    var dp = [[Int]](repeating: [Int](repeating: 0, count: target + 1), count: n + 1)

    for i in 0...n{
      dp[i][0] = 1
    }

    for i in 1...n{
      for j in 1...target{
        print("candidates[i - 1]: \(candidates[i - 1])")
        if j < candidates[i - 1] {
          dp[i][j]=dp[i - 1][j]
        } else {
          print("dp[i - 1][j]: \(dp[i - 1][j])")
          print("dp[i][j - candidates[i - 1]]: \(dp[i][j - candidates[i - 1]])")
          let x = dp[i - 1][j]
          let y = dp[i][j - candidates[i - 1]]
          dp[i][j] = x + y
        }
      }
    }
    for row in dp {
      print(row)
    }
    return [[]]
  }


  let candidates = readLine()!.split(separator: " ").map { Int($0)! }
  let target = Int(readLine()!)!
  let result = combinationSum(candidates, target)
  print(result)

}
