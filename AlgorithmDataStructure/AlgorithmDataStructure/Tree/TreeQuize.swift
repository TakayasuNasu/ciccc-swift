//
//  TreeQuize.swift
//  AlgorithmDataStructure
//
//  Created by Takayasu Nasu on 2021/03/18.
//

import Foundation


func treeTraversalForTreeQuize() {

  // let input = [[1,6],[6,3],[3,5],[4,1],[2,4],[4,7]]
  let input = [[1,2],[1,3],[2,4],[3,5],[3,6],[4,7],[4,8],[5,9],[5,10],[6,11],[6,12]]
  var tree = [[Int]](repeating: [Int](repeating: 0, count: 0), count: input.count)

  func setTree(_ input: [[Int]]) {
    if input.count == 0 { return }
    var first = input.first!
    if first.contains(1) {
      first.removeAll(where: { $0 == 1 })
      tree[0].append(first[0])
    } else {
      for node in tree {
        if node.contains(first[0]) {
          tree[first[0] - 1].append(first[1])
        } else if node.contains(first[1]) {
          tree[first[1] - 1].append(first[0])
        }
      }
    }

    var newInput = input
    newInput.removeFirst()
    setTree(newInput)
  }


  func inOrder(_ node: Int) {
  }

  setTree(input)
  print(tree)
  for i in 1...input.count + 1 {
    for (index, node) in tree.enumerated() {
      if node.contains(i) {
        print(index + 1)
      }
    }
  }

  inOrder(0)
}


func diameterForTreeQuize() {
//  let input = [[1,3],[2,4],[3,1],[4,2],[5,4]]
  var tree = [[Int]](repeating: [Int](repeating: 0, count: 0), count: 5)
  tree[1 - 1].append(3)
  tree[3 - 1].append(1)

  tree[2 - 1].append(4)
  tree[4 - 1].append(2)

  tree[3 - 1].append(4)
  tree[4 - 1].append(3)

  tree[5 - 1].append(4)
  tree[4 - 1].append(5)


  func dfs(_ list: [[Int]], _ node: Int, _ arrival: Int) {
    for i in 0..<list[node - 1].count {
      if list[node - 1][i] != arrival {
        print(list[node - 1][i], ": \(node)")
        dfs(list, list[node - 1][i], node)
      }
    }
  }

  dfs(tree, 1, 0)
}
