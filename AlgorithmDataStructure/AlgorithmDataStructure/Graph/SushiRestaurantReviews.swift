//
//  SushiRestaurantReviews.swift
//  AlgorithmDataStructure
//
//  Created by Takayasu Nasu on 2021/03/24.
//

import Foundation

func sushiRestaurant() {

  var store: [[Int]] = []

  func checkVisited(_ visited: [Int], _ store: inout [[Int]]) {
    if visited.contains(6) && visited.contains(4) && visited.contains(7) {
      store.append(visited)
    }
  }

  func dfs(vertex: Int, _ restaurantMap: inout [[Int]], _ stack: inout [Bool], _ visited: inout [Int]) {
    stack[vertex] = true
    for (i,v) in restaurantMap[vertex].enumerated() {
      if v == 0 { continue }
      if stack[i] { continue }
      let last = visited.last!
      visited.append(i)
      dfs(vertex: i, &restaurantMap, &stack, &visited)
      if visited.count < 8 {
        visited.append(last)
      }
      checkVisited(visited, &store)
    }
  }

  let input: [[Int]] = [[0,1],[0,2],[2,3],[4,3],[6,1],[1,5],[7,3]]
  let n = 8
  var restaurantMap = [[Int]](repeating: [Int](repeating: 0, count: n), count: n)
  for i in 0..<n - 1 {
    let row = input[i][0]
    let col = input[i][1]
    restaurantMap[row][col] = 1
    restaurantMap[col][row] = 1
  }

  for row in restaurantMap {
    print(row)
  }

  print("==========")

  var stack = [Bool](repeating: false, count: n)
  var visited: [Int] = []
  for row in 0..<n {
    visited.append(row)
    dfs(vertex: row, &restaurantMap, &stack, &visited)
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
  print(minRoad.count)

}
