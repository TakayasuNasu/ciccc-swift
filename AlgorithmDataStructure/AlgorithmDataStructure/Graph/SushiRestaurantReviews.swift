//
//  SushiRestaurantReviews.swift
//  AlgorithmDataStructure
//
//  Created by Takayasu Nasu on 2021/03/24.
//

import Foundation

func sushiRestaurant() {

  var store: [[Int]] = []
  let firstLine: [Int] = readLine()!.split(separator: " ").map { Int($0)! }
  let realSushiRestaurants: [Int] = readLine()!.split(separator: " ").map { Int($0)! }


  func didVisitNecessaryRestaulant(_ visited: [Int]) -> Bool {
    for restaurant in realSushiRestaurants {
      if !visited.contains(restaurant) {
        return false
      }
    }
    return true
  }

  func checkVisited(_ visited: [Int], _ store: inout [[Int]]) {
    if didVisitNecessaryRestaulant(visited) {
      store.append([Int](visited[0..<visited.count - 1]))
    }
  }

  func dfs(lastVisited: Int, _ restaurantMap: inout [[Int]], _ stack: inout [Bool], _ visited: inout [Int]) {
    stack[lastVisited] = true
    for (col,zeroOrOne) in restaurantMap[lastVisited].enumerated() {
      if zeroOrOne == 0 { continue }
      if stack[col] { continue }
      visited.append(col)
      dfs(lastVisited: col, &restaurantMap, &stack, &visited)
      if stack.filter({ $0 }).count > 1 {
        visited.append(lastVisited)
      }
      checkVisited(visited, &store)
    }
  }

  func optimizeMap(_ row: Int, _ restaurantMap: inout [[Int]], _ fakeRestaurants: [Int]) {
    if row == restaurantMap.count { return }
    for (col, _) in restaurantMap[row].enumerated() {
      if fakeRestaurants.contains(col) {
        restaurantMap[row][col] = 0
      }
    }
    optimizeMap(row + 1, &restaurantMap, fakeRestaurants)
  }

  func getFakaRestaurants(_ restaurantMap: [[Int]], _ skip: [Int]) -> [Int] {
    var fakeRestaurants: [Int] = []
    for (i,row) in restaurantMap.enumerated() {
      if skip.contains(i) { continue }
      var count = 0
      for n in row {
        if n == 1 {
          count += 1
        }
      }
      if count < 2 { fakeRestaurants.append(i) }
    }
    return fakeRestaurants
  }

  let n = firstLine[0]
  var input: [[Int]] = [[Int]](repeating: [Int](repeating: 0, count: 2), count: n)
  for i in 0..<n - 1 {
    let edge = readLine()!.split(separator: " ").map { Int($0)! }
    input[i][0] = edge[0]
    input[i][1] = edge[1]
  }

  var restaurantMap = [[Int]](repeating: [Int](repeating: 0, count: n), count: n)
  for i in 0..<n - 1 {
    let row = input[i][0]
    let col = input[i][1]
    restaurantMap[row][col] = 1
    restaurantMap[col][row] = 1
  }

  let fakeRestaurants = getFakaRestaurants(restaurantMap, realSushiRestaurants)

  print(fakeRestaurants)

  optimizeMap(0, &restaurantMap, fakeRestaurants)

  for row in restaurantMap {
    print(row)
  }

  print("==========")

  var stack = [Bool](repeating: false, count: n)
  var visited: [Int] = []
  for row in 0..<n {
    visited.append(row)
    dfs(lastVisited: row, &restaurantMap, &stack, &visited)
    visited.removeAll()
    stack = [Bool](repeating: false, count: n)
  }


  print()
  var minRoad = store[0]
  for s in store {
    print(s)
    if minRoad.count > s.count {
      minRoad = s
    }
  }
  print()
  print(minRoad)
  print(minRoad.count - 1)

}

func sushiRestaurantForCheck() {

  func dfs(vertex: Int, _ restaurantMap: inout [[Int]], _ visited: inout [Bool]) {
    visited[vertex] = true
    for (col,v) in restaurantMap[vertex].enumerated() {
      if v == 0 { continue }
      if visited[col] { continue }
      print(col, terminator: " ")
      dfs(vertex: col, &restaurantMap, &visited)
      print("-> \(vertex)")
      print()
    }
  }


  func prepare(_ n: Int) -> [[Int]] {
    let input: [[Int]] = [[7, 6], [7, 2], [8, 3], [1, 2], [2, 5], [3, 4], [0, 6], [2, 3], [0, 0]]

    print(input)
    print()

    var restaurantMap = [[Int]](repeating: [Int](repeating: 0, count: n), count: n)
    for i in 0..<n - 1 {
      let row = input[i][0]
      let col = input[i][1]
      restaurantMap[row][col] = 1
      restaurantMap[col][row] = 1
    }
    return restaurantMap
  }

  func optimizeMap(_ row: Int, _ restaurantMap: inout [[Int]], _ fakeRestaurants: [Int]) {
    if row == restaurantMap.count { return }
    for (col, _) in restaurantMap[row].enumerated() {
      if fakeRestaurants.contains(col) {
        restaurantMap[row][col] = 0
      }
    }
    optimizeMap(row + 1, &restaurantMap, fakeRestaurants)
  }

  func getFakaRestaurants(_ restaurantMap: [[Int]], _ skip: [Int]) -> [Int] {
    var fakeRestaurants: [Int] = []
    for (i,row) in restaurantMap.enumerated() {
      if skip.contains(i) { continue }
      var count = 0
      for n in row {
        if n == 1 {
          count += 1
        }
      }
      if count < 2 { fakeRestaurants.append(i) }
    }
    return fakeRestaurants
  }

  let n = 9
  var restaurantMap = prepare(n)

  let fakeRestaurants = getFakaRestaurants(restaurantMap, [0,8,1])

  print(fakeRestaurants)

  optimizeMap(0, &restaurantMap, fakeRestaurants)

  print()

  for row in restaurantMap {
    print(row)
  }

  print()

  var visited = [Bool](repeating: false, count: n + 1)
  for v in 0..<n {
    print(v, terminator: " ")
    dfs(vertex: v, &restaurantMap, &visited)
  }

}
