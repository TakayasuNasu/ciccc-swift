//
//  SushiSolution.swift
//  AlgorithmDataStructure
//
//  Created by Takayasu Nasu on 2021/04/04.
//

import Foundation

func sushiSolution() {

  var fakeRestaurantList: [[Int]] = []
  var distance: Int = 0
  var diameter: Int = 0
  
  func makeMap(_ n: Int) -> [[Int]] {
    var restaurantMap = [[Int]](repeating: [Int](repeating: 0, count: n), count: n)
    for _ in 0..<n - 1 {
      let edge = readLine()!.split(separator: " ").map { Int($0)! }
      let u = edge[0]
      let v = edge[1]
      restaurantMap[u][v] = 1
      restaurantMap[v][u] = 1
    }
    return restaurantMap
  }

  func optimizeMap(_ restaurantMap: inout [[Int]], _ realSushiRestaurants: [Int]) {
    let fakeRestaurants = getFakaRestaurants(restaurantMap, realSushiRestaurants)
    if fakeRestaurants.count > 0 {
      fakeRestaurantList.append(fakeRestaurants)
      removeEdge(&restaurantMap, fakeRestaurants)
      optimizeMap(&restaurantMap, realSushiRestaurants)
    }
  }

  func getFakaRestaurants(_ restaurantMap: [[Int]], _ skip: [Int]) -> [Int] {
    var fakeRestaurants: [Int] = []
    for (i,row) in restaurantMap.enumerated() {
      if skip.contains(i) { continue }
      var count = 0
      for col in row {
        if col == 1 { count += 1 }
      }
      if count == 1 { fakeRestaurants.append(i) }
    }
    return fakeRestaurants
  }

  func removeEdge(_ restaurantMap: inout [[Int]], _ fakeRestaurants: [Int], _ row: Int = 0) {
    if row == restaurantMap.count { return }
    for (col, _) in restaurantMap[row].enumerated() {
      if fakeRestaurants.contains(row) {
        restaurantMap[row][col] = 0
      }
      if fakeRestaurants.contains(col) {
        restaurantMap[row][col] = 0
      }
    }
    removeEdge(&restaurantMap, fakeRestaurants, row + 1)
  }

  func makeStack(_ list: [Int], _ count: Int) -> [Bool] {
    var stack = [Bool](repeating: false, count: count)
    for row in list {
      stack[row] = true
    }
    return stack
  }

  func bfs(_ node: Int, _ restaurantMap: inout [[Int]],  _ stack: inout [Bool]) -> Int {
    let q = Queue<Int>()
    var distance = 0
    q.enqueue(item: node)
    while !q.isEmpty() {
      let visitedNode = q.dequeue()!
      stack[visitedNode] = true
      for (col,zeroOrOne) in restaurantMap[visitedNode].enumerated() {
        if zeroOrOne == 0 { continue }
        if stack[col] { continue }
        q.enqueue(item: col)
        distance = col
      }
    }
    return distance
  }

  func dfs(from: Int, _ restaurantMap: inout [[Int]],  _ stack: inout [Bool]) {
    stack[from] = true
    if distance > diameter {
      diameter = distance
    }
    for (col,zeroOrOne) in restaurantMap[from].enumerated() {
      if zeroOrOne == 0 { continue }
      if stack[col] { continue }
      distance += 1
      dfs(from: col, &restaurantMap, &stack)
      distance -= 1
    }
  }

  let firstLine: [Int] = readLine()!.split(separator: " ").map { Int($0)! }
  let n = firstLine[0]
  let realSushiRestaurants: [Int] = readLine()!.split(separator: " ").map { Int($0)! }
  var restaurantMap = makeMap(n)
  optimizeMap(&restaurantMap, realSushiRestaurants)
  var stack = makeStack(fakeRestaurantList.flatMap { $0 }, n)

//  for (i, row) in restaurantMap.enumerated() {
//    print("\(i):", row)
//  }

  print()
  let from = bfs(realSushiRestaurants[0], &restaurantMap, &stack)
  stack = makeStack(fakeRestaurantList.flatMap { $0 }, n)
  dfs(from: from, &restaurantMap, &stack)
  let nodeNum: Int = {
    var count = 0
    for row in restaurantMap {
      if row.contains(1) {
        count += 1
      }
    }
    return count
  }()

  print((nodeNum - 1) * 2 - diameter)
}
