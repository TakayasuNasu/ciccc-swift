//
//  MST.swift
//  AlgorithmDataStructure
//
//  Created by Takayasu Nasu on 2021/04/09.
//

import Foundation

public final class MST {

  func kruskaLMST(_ graph: [[(v: Int, w: Int)]]) -> (Int, [(Int, Int, Int)]) {
    var allEdges = [(u: Int, v: Int, w: Int)]()
    var mstEdges = [(u: Int, v: Int, w: Int)]()

    for (u, node) in graph.enumerated() {
      for edge in node {
        allEdges.append((u: u, v: edge.v, w: edge.w))
      }
    }
    allEdges.sort { $0.w < $1.w }

    var uf = UF(graph.count)
    for edge in allEdges {
      if uf.connected(edge.u, edge.v) { continue }
      uf.union(edge.u, edge.v)
      mstEdges.append(edge)
    }

    return (mstEdges.map { $0.w }.reduce(0, +), mstEdges)
  }

  func primMST(_ graph: [[(v: Int, w: Int)]]) -> (Int, [CompEdge]) {
    let n = graph.count
    var mstEdges = [CompEdge]()
    var pq = IndexPriorityQueue<CompEdge>(<)
    var visited = [Bool](repeating: false, count: n)
    visited[0] = true
    for edge in graph[0] {
      pq.enqueue(CompEdge(v: edge.v, w: edge.w))
    }

    while let edge = pq.dequeue() {
      if !visited[edge.v] {
        visited[edge.v] = true
        mstEdges.append(edge)
        for e in graph[edge.v] {
          pq.enqueue(CompEdge(v: e.v, w: e.w))
        }
      }
    }
    return (mstEdges.map { $0.w }.reduce(0, +), mstEdges)

  }
}

struct CompEdge {
  var v: Int
  var w: Int
}

extension CompEdge: Comparable {
  static func < (lhs: CompEdge, rhs: CompEdge) -> Bool {
    return lhs.w < rhs.w
  }
}

extension CompEdge: Hashable {}
