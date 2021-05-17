//
//  BellmanFord.swift
//  AlgorithmDataStructure
//
//  Created by Takayasu Nasu on 2021/04/13.
//

import Foundation

func bellmanFord(_ edges: [(u: Int, v: Int, w: Int)], _ n: Int, _ src: Int) -> [Int64] {
  var dist = [Int64](repeating: Int64(Int.max), count: n + 1) // 1-indexed
  dist[src] = 0

  // N - 1 times
  for _ in 0..<n-1 {
    // relax all edges
    for edge in edges {
      if dist[edge.v] > dist[edge.u] + Int64(edge.w) {
        dist[edge.v] = dist[edge.u] + Int64(edge.w)
      }
    }
  }

  return dist
}


func runBellmanFord() {

  let firstLine = readLine()!.split(separator: " ").map { Int($0)! }
  let n = firstLine[0]
  //  let b = firstLine[1]
  // var matrix = [[Int]](repeating: [Int](repeating: 0, count: n), count: n)
  var edges = [(u: Int, v: Int, w: Int)](repeating: (u:0,v:0,w:0), count: n)

  for i in 0..<n {
    let busInfo = readLine()!.split(separator: " ").map { Int($0)! }
    let u = busInfo[0]
    let v = busInfo[1]
    let w = busInfo[2]
    edges[i] = (u:u,v:v,w:w)
  }

  let result = bellmanFord(edges, n, 1)
  print()
  print(result)
}


func shortestPath() {

  struct Edge {
    let to: Int
    let weight: Int
  }

  let inf = 100_000

  func shortestPathFasterAlgorithm(_ adj: inout [[Edge]], _ n: Int, _ src: Int) -> [Int] {
    var dist = [Int](repeating: inf, count: n + 1)
    var check = [Bool](repeating: false, count: n + 1)
    let q = Queue<Int>()
    q.enqueue(item: src)
    dist[src] = 0
    check[src] = false

    while !q.isEmpty() {
      let from = q.dequeue()!
      check[from] = false
    }
    return []
  }
}


