//
//  TreeQuize.swift
//  TryAgainAssignment
//
//  Created by Takayasu Nasu on 2021/04/22.
//

import Foundation

func FindPAllarentNode() {

  func findPAllarentNode(_ adjList: [[Int]], _ n: Int) {
    for i in 2...n {
      for (j, row) in adjList.enumerated() {
        if row.contains(i) {
          print(j + 1)
        }
      }
    }
  }

  let n = Int(readLine()!)!
  var adjList = [[Int]](repeating: [], count: n)
  var store: [Int] = []

  for _ in 0..<n - 1 {
    let edge = readLine()!.split(separator: " ").map { Int($0)! }
    let i = edge[0]
    let j = edge[1]
    if j == 1 {
      adjList[j - 1].append(i)
      store.append(i)
    } else if store.contains(j) {
      adjList[j - 1].append(i)
      store.append(i)
    } else {
      adjList[i - 1].append(j)
      store.append(j)
    }
  }

  findPAllarentNode(adjList, n)

}

func DiameterForTreeQuize() {

  // mostDistant(distance, diameter, lastVisited)
  func dfs(_ lastVisited: Int, _ matrix: inout [[Int]], _ visited: inout [Bool], _ mostDistant: inout (Int, Int, Int)) {
    visited[lastVisited] = true
    if mostDistant.0 > mostDistant.1 {
      mostDistant.1 = mostDistant.0
      mostDistant.2 = lastVisited
    }
    for (col, distant) in matrix[lastVisited].enumerated() {
      if distant == 0 { continue }
      if visited[col] { continue }
      mostDistant.0 += distant
      dfs(col, &matrix, &visited, &mostDistant)
      mostDistant.0 -= distant
    }
  }


  func makeMatrix(_ n: Int) -> [[Int]] {
    var matrix = [[Int]](repeating: [Int](repeating: 0, count: n), count: n)
    for _ in 0..<n - 1 {
      let edge = readLine()!.split(separator: " ").map { Int($0)! }
      let u = edge[0] - 1
      var count = 1
      while edge[count] != -1 {
        let v = edge[count] - 1
        let w = edge[count + 1]
        matrix[u][v] = w
        matrix[v][u] = w
        count += 2
      }
    }
    
    return matrix
  }

  let n = Int(readLine()!)!
  var matrix = makeMatrix(n)

  print()

  for row in matrix {
    print(row)
  }

  // mostDistant(distance, diameter, lastVisited)
  var mostDistant: (Int,Int, Int) = (0,0,0)
  var visited = [Bool](repeating: false, count: n)
  dfs(0, &matrix, &visited, &mostDistant)
  let from = mostDistant.2
  mostDistant = (0,0,0)
  visited = [Bool](repeating: false, count: n)
  dfs(from, &matrix, &visited, &mostDistant)
  print(mostDistant.1)

}

func LCA() {

  var store: Set<Int> = []
  var result = 0

  func dfs(_ lastVisited: Int, _ matrix: inout [[Int]], _ stack: inout [Bool], _ test: (Int, Int)) {
    stack[lastVisited] = true
    for (col, zeroOrOne) in matrix[lastVisited].enumerated() {
      if zeroOrOne == 0 { continue }
      if stack[col] { continue }
      if col + 1 == test.0 || col + 1 == test.1 {
        print("col: \(col + 1)")
        store.insert(col)
      }
      if store.count == 2 {
        print("if store > 1 -> col: \(col + 1), lastVisit: \(lastVisited + 1)")
        result = lastVisited + 1
        store.insert(99)
      }
      dfs(col, &matrix, &stack, test)
    }

  }

  func makeMatrix(_ n: Int) -> [[Int]] {
    var matrix = [[Int]](repeating: [Int](repeating: 0, count: n), count: n)
    for _ in 0..<n - 1 {
      let edge = readLine()!.split(separator: " ").map { Int($0)! }
      let u = edge[0] - 1
      let v = edge[1] - 1
      matrix[u][v] = 1
      matrix[v][u] = 1
    }

    return matrix
  }

  let n = Int(readLine()!)!
  var matrix = makeMatrix(n)
  let tc = Int(readLine()!)!
  var testCase = [(Int, Int)](repeating: (0,0), count: tc)
  for i in 0..<tc {
    let edge = readLine()!.split(separator: " ").map { Int($0)! }
    testCase[i].0 = edge[0]
    testCase[i].1 = edge[1]
  }
  var stack = [Bool](repeating: false, count: n)
  for test in testCase {
    print()
    dfs(0, &matrix, &stack, test)
    if store.count < 2 {
      print("result: \(1)")
    } else {
      print("result: \(result)")
    }
    store = []
    stack = [Bool](repeating: false, count: n)
  }


}
