//
//  LowestCommonAncestor.swift
//  AlgorithmDataStructure
//
//  Created by Takayasu Nasu on 2021/03/22.
//

import Foundation

func lowestCommonAncestor() {
  let n = Int(readLine()!)!
  var adj = [[Int]](repeating: [], count: n + 1)
  var parents: Set<Int> = [1]
  for _ in 0..<n - 1 {
    let edge = readLine()!.split(separator: " ").map { Int($0)! }
    let u = edge[0]
    let v = edge[1]
    if !parents.contains(v) {
      adj[u].append(v)
      parents.insert(v)
    }
    if !parents.contains(u) {
      adj[v].append(u)
      parents.insert(u)
    }
  }
  print(adj)

  let m = Int(readLine()!)!
  var mj = [[Int]](repeating: [], count: m)
  for i in 0..<m {
    let edge = readLine()!.split(separator: " ").map { Int($0)! }
    mj[i].append(contentsOf: edge)
  }

  var store: [Int] = []
  var left: [Int] = []
  var right: [Int] = []

  func postOrder(_ node: Int, _ p: Int, _ q: Int) {
    if adj[node].count == 0 { return }
    store.append(node)
    for i in 0..<adj[node].count {
      if adj[node][i] == p {
        left = store
      }
      if adj[node][i] == q {
        right = store
      }
      postOrder(adj[node][i], p, q)
    }
    store.removeLast()
  }


  for l in mj {
    postOrder(1, l[0], l[1])
    var result :Int = 1
    for i in left {
      for j in right {
        if i == j {
          result = j
        }
      }
    }
    print(result)
  }

}

