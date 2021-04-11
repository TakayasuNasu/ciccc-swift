//
//  Sushi.swift
//  SwiftAGDS
//
//  Created by Derrick Park on 7/24/20.
//  Copyright © 2020 Derrick Park. All rights reserved.
//

import Foundation

func SushiIterative() {
  /// The Stack class represents a last-in-first-out (LIFO) stack of generic items.
  /// It supports the usual *push* and *pop* operations, along with methods for peeking at the top item, testing if the stack is empty, and iterating through the items in LIFO order.
  /// This implementation uses a singly linked list with an inner class for linked list nodes.
  class Stack<E> : Sequence {
    /// top of stack
    private var first: Node<E>? = nil
    /// size of the stack
    private(set) var count: Int = 0
    
    /// helper linked list node class
    fileprivate class Node<E> {
      fileprivate var item: E
      fileprivate var next: Node<E>?
      fileprivate init(item: E, next: Node<E>? = nil) {
        self.item = item
        self.next = next
      }
    }
    
    /// Initializes an empty stack.
    public init() {}
    
    /// Adds the item to this stack
    /// - Parameter item: the item to add
    public func push(item: E) {
      first = Node(item: item, next: first)
      count += 1
    }
    
    /// Removes and returns the item most recently added to this stack.
    public func pop() -> E? {
      guard let first = first else { return nil }
      self.first = first.next
      count -= 1
      return first.item
    }
    
    /// Returns (but does not remove) the item most recently added to this stack.
    public func peek() -> E? {
      return first?.item ?? nil
    }
    
    /// Returns true if this stack is empty.
    public func isEmpty() -> Bool {
      return count == 0
    }
    
    /// StackIterator that iterates over the items in LIFO order.
    public struct StackIterator<E> : IteratorProtocol {
      private var current: Node<E>?
      
      fileprivate init(_ first: Node<E>?) {
        current = first
      }
      
      public mutating func next() -> E? {
        if let current = current {
          self.current = current.next
          return current.item
        } else { return nil }
      }
      
      public typealias Element = E
    }
    
    /// Returns an iterator that iterates over the items in this Stack in LIFO order.
    public __consuming func makeIterator() -> StackIterator<E> {
      return StackIterator<E>(first)
    }
  }
  
  func sushiReviews() {
    let numOfSets = readLine()!.split(separator: " ")
    let numOfRestaurants = Int(numOfSets[0])!
    let realSushiList = readLine()!.split(separator: " ")
    
    var adjacents = [[Int]](repeating: [Int](), count: numOfRestaurants)
    var checkRealSushi = [Bool](repeating: false, count: numOfRestaurants)
    
    for real in realSushiList { checkRealSushi[Int(real)!] = true }
    
    for _ in 1..<numOfRestaurants {
      let vertices = readLine()!.split(separator: " ")
      let u = Int(vertices[0])!, v = Int(vertices[1])!
      adjacents[u].append(v)
      adjacents[v].append(u)
    }
    
    let (startNode, _) = getMaxDistanceWithIndex(from: 0, checkRealSushi: checkRealSushi, adjacents: adjacents)
    let (_, maxDist) = getMaxDistanceWithIndex(from: startNode, checkRealSushi: checkRealSushi, adjacents: adjacents)
    
    let result = dfsForRealSushi(rootNode: startNode, checkRealSushi, adjacents) - maxDist
    print(result)
  }
  
  func dfsForRealSushi(rootNode: Int, _ checkRealSushi: [Bool], _ adjacents: [[Int]]) -> Int {
    let dfsStack = Stack<Int>()
    let numOfNodes = adjacents.count
    
    var visited = [Bool](repeating: false, count: numOfNodes)
    var hasChildRealSushi = [Bool](repeating: false, count: numOfNodes)
    
    dfsStack.push(item: rootNode)
    
    while !dfsStack.isEmpty() {
      let pop = dfsStack.pop()!
      let hasRealSushi = checkRealSushi[pop]
      
      if !visited[pop] {
        hasChildRealSushi[pop] = hasRealSushi
        for v in adjacents[pop] {
          if !visited[v] {
            dfsStack.push(item: pop)
            dfsStack.push(item: v)
            if checkRealSushi[v] { hasChildRealSushi[pop] = true }
          }
        }
        visited[pop] = true
      } else {
        if hasChildRealSushi[pop] {
          let peek = dfsStack.peek()
          if let peek = peek {
            if visited[peek] && !hasChildRealSushi[peek] { hasChildRealSushi[peek] = true }
          }
        }
      }
    }
    
    var total = 0
    for b in hasChildRealSushi { if b { total += 1 } }
    
    return (total - 1) * 2
  }
  
  func getMaxDistanceWithIndex(from root: Int, checkRealSushi: [Bool], adjacents: [[Int]]) -> (Int, Int) {
    let dfsStack = Stack<Int>()
    let numOfNodes = adjacents.count
    var visited = [Bool](repeating: false, count: numOfNodes)
    var depth = [Int](repeating: 0, count: numOfNodes)
    
    var maxIndex = root, maxValue = depth[root]
    
    dfsStack.push(item: root)
    while !dfsStack.isEmpty() {
      let pop = dfsStack.pop()!
      for v in adjacents[pop] {
        if !visited[v] {
          dfsStack.push(item: v)
          depth[v] = depth[pop] + 1
          if checkRealSushi[v] && maxValue < depth[v] {
            maxIndex = v
            maxValue = depth[v]
          }
        }
      }
      visited[pop] = true
    }
    
    return (maxIndex, maxValue)
  }
  
  sushiReviews()
}
