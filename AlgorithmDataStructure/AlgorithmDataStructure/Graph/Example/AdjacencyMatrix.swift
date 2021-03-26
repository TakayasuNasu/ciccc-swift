//
//  AdjacencyMatrix.swift
//  AlgorithmDataStructure
//
//  Created by Takayasu Nasu on 2021/03/23.
//

import Foundation

func AdjacencyMatrixRepresentation() {
  let firstLine = readLine()!.split(separator: " ")
  let n = Int(firstLine[0])!
  let m = Int(firstLine[1])!

  // n * m
  var adjMatrix = [[Int]](repeating: [Int](repeating: 0, count: n), count: n)
  for _ in 0..<m {
    let edge = readLine()!.split(separator: " ").map { Int($0)! }
    let u = edge[0]
    let v = edge[1]
    // u - 1 v -1
    adjMatrix[u - 1][v - 1] = 1
    adjMatrix[v - 1][u - 1] = 1
  }
  
  for row in adjMatrix {
    print(row)
  }

}
