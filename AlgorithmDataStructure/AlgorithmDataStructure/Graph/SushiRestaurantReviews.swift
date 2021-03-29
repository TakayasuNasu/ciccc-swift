//
//  SushiRestaurantReviews.swift
//  AlgorithmDataStructure
//
//  Created by Takayasu Nasu on 2021/03/24.
//

import Foundation

func sushiRestaurant() {

  var fakeRestaurantList: [[Int]] = []

  func dfs(lastVisited: Int, _ restaurantMap: inout [[Int]], _ stack: inout [Bool], _ visited: inout [Int]) {
    stack[lastVisited] = true
    var skipNodes: [Int] = []
    for (col,zeroOrOne) in restaurantMap[lastVisited].enumerated() {
      if zeroOrOne == 0 { continue }
      if stack[col] { continue }

      if hasNext(col, &restaurantMap, &stack) {
        skipNodes.append(col)
        continue
      }

      visited.append(col)
      dfs(lastVisited: col, &restaurantMap, &stack, &visited)
      if stack.filter({ !$0 }).count > 0 {
        visited.append(lastVisited)
      }
    }
    for col in skipNodes {
      visited.append(col)
      dfs(lastVisited: col, &restaurantMap, &stack, &visited)
    }
  }

  func hasNext(_ row: Int, _ restaurantMap: inout [[Int]], _ stack: inout [Bool]) -> Bool {
    for (col,zeroOrOne) in restaurantMap[row].enumerated() {
      if zeroOrOne == 0 { continue }
      if stack[col] { continue }
      return true
    }
    return false
  }

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

  func save(_ visited: [Int], _ store: inout [Int]) {
    if store.count == 0 {
      store = visited
    } else if visited.count < store.count {
      store = visited
    }
  }

  let firstLine: [Int] = readLine()!.split(separator: " ").map { Int($0)! }
  let n = firstLine[0]
  let realSushiRestaurants: [Int] = readLine()!.split(separator: " ").map { Int($0)! }
  var restaurantMap = makeMap(n)
  optimizeMap(&restaurantMap, realSushiRestaurants)


  //  for (i, row) in restaurantMap.enumerated() {
  //    print("\(i): ", row)
  //  }

  var stack = makeStack(fakeRestaurantList.flatMap { $0 }, n)
  var visited: [Int] = []
  var store: [Int] = []
  for row in realSushiRestaurants {
    visited.append(row)
    dfs(lastVisited: row, &restaurantMap, &stack, &visited)
    save(visited, &store)
    visited.removeAll()
    stack = makeStack(fakeRestaurantList.flatMap { $0 }, n)
  }
  print(store.count - 1)


}
