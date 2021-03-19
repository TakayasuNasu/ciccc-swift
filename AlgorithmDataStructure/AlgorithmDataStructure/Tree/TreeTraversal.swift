//
//  TreeTraversal.swift
//  AlgorithmDataStructure
//
//  Created by Takayasu Nasu on 2021/03/16.
//

import Foundation

class TreeNode<T> {
  var data: T?
  var left: TreeNode<T>?
  var right: TreeNode<T>?
  init(_ data: T?) {
    self.data = data
    self.left = nil
    self.right = nil
  }
}

func treeTraversal() {
  var tree = [[Int]](repeating: [Int](repeating: 0, count: 2), count: 26)
  let n = Int(readLine()!)!
  for _ in 0..<n {
    // nodeInfo = ["A", "B", "C"]
    let nodeInfo = readLine()!.split(separator: " ").map { String($0) }
    let parent = Int(Character(nodeInfo[0]).asciiValue! - 65)
    let left = Int(Character(nodeInfo[1]).asciiValue!)
    let right = Int(Character(nodeInfo[2]).asciiValue!)
    // ascii for . is 46 -> -1
    tree[parent][0] = left == 46 ? -1 : left - 65
    tree[parent][1] = right == 46 ? -1 : right - 65
  }

  func preOrder(_ node: Int) {
    if node == -1 { return }
    print(Character(UnicodeScalar(node + 65)!), terminator: "")
    preOrder(tree[node][0])
    preOrder(tree[node][1])
  }

  func inOrder(_ node: Int) {
    if node == -1 { return }
    inOrder(tree[node][0])
    print(Character(UnicodeScalar(node + 65)!), terminator: "")
    inOrder(tree[node][1])
  }

  func postOrder(_ node: Int) {
    if node == -1 { return }
    postOrder(tree[node][0])
    postOrder(tree[node][1])
    print(Character(UnicodeScalar(node + 65)!), terminator: "")
  }

  preOrder(0)
  print()
  inOrder(0)
  print()
  postOrder(0)
  print()
}
