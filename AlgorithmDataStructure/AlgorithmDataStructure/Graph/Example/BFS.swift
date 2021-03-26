//
//  BFS.swift
//  AlgorithmDataStructure
//
//  Created by Takayasu Nasu on 2021/03/23.
//

import Foundation


func AdjacencyListBFS() {
  let firstLine = readLine()!.split(separator: " ")
  let n = Int(firstLine[0])!
  let m = Int(firstLine[1])!

  // n * m
  var adjList = [[Int]](repeating: [], count: n + 1)
  for _ in 0..<m {
    let edge = readLine()!.split(separator: " ").map { Int($0)! }
    let u = edge[0]
    let v = edge[1]

    adjList[u].append(v)
    adjList[v].append(u)
  }

  var visited = [Bool](repeating: false, count: n + 1)
  let queue = Queue<Int>()
  queue.enqueue(item: 1)
  visited[1] = true

  while !queue.isEmpty() {
    let vertex = queue.dequeue()!
    print(vertex)
    for v in adjList[vertex] {
      if !visited[v] {
        queue.enqueue(item: v)
        visited[v] = true
      }
    }
  }
}
