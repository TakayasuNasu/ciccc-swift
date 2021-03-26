//
//  DFS.swift
//  AlgorithmDataStructure
//
//  Created by Takayasu Nasu on 2021/03/23.
//

import Foundation

func AdjacencyListDFS() {
  let firstLine = readLine()!.split(separator: " ")
  let n = Int(firstLine[0])!
  let m = Int(firstLine[1])!

  // n * m
  var adjList = [[(v: Int, w: Int)]](repeating: [], count: n + 1)
  for _ in 0..<m {
    let edge = readLine()!.split(separator: " ").map { Int($0)! }
    let u = edge[0]
    let v = edge[1]
    let w = edge[2]
    
    adjList[u].append((v, w))
    adjList[v].append((u, w))
  }

  func dfs(vertex: Int, adjList: inout [[(v: Int, w: Int)]], visited: inout [Bool]) {
    visited[vertex] = true
    print(vertex)
    for v in adjList[vertex] {
      if !visited[v.0] {
        dfs(vertex: v.0, adjList: &adjList, visited: &visited)
      }
    }
  }

  var visited = [Bool](repeating: false, count: n + 1)
  dfs(vertex: 1, adjList: &adjList, visited: &visited)

}
