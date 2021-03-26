//
//  ConnectedComponents.swift
//  AlgorithmDataStructure
//
//  Created by Takayasu Nasu on 2021/03/23.
//

import Foundation

func connectedComponents() {
  let firstLine = readLine()!.split(separator: " ")
  let n = Int(firstLine[0])!
  let m = Int(firstLine[1])!

  var adjList = [[Int]](repeating: [], count: n + 1)

  for _ in 0..<m {
    let edge = readLine()!.split(separator: " ")
    let u = Int(edge[0])!
    let v = Int(edge[1])!

    adjList[u].append(v)
    adjList[v].append(u)
  }


  func dfs(vertex: Int, adjList: inout [[Int]], visited: inout [Bool]) {
    visited[vertex] = true
    for v in adjList[vertex] {
      if !visited[v] {
        dfs(vertex: v, adjList: &adjList, visited: &visited)
      }
    }
  }

  var visited = [Bool](repeating: false, count: n + 1)
  var count = 0
  for v in 1...n {
    if !visited[v] {
      dfs(vertex: v, adjList: &adjList, visited: &visited)
      count += 1
    }
  }
  print(count)
}
