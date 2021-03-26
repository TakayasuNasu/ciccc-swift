//
//  AdjacencyList.swift
//  AlgorithmDataStructure
//
//  Created by Takayasu Nasu on 2021/03/23.
//

import Foundation

func AdjacencyListRepresentation() {
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
    // u - 1 v -1
    adjList[u].append((v, w))
    adjList[v].append((u, w))
  }

  for i in adjList {
    print(i)
  }

}
