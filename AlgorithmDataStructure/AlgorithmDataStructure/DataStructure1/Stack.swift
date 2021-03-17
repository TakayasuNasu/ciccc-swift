//
//  Stack.swift
//  AlgorithmDataStructure
//
//  Created by Takayasu Nasu on 2021/03/15.
//

import Foundation

public final class Stack<E>: Sequence{

  private var first: Node<E>? = nil
  private(set) var count: Int = 0

  fileprivate class Node<E> {
    
    fileprivate var item: E
    fileprivate var next: Node<E>?

    fileprivate init(item: E, next: Node<E>? = nil) {
      self.item = item
      self.next = next
    }
  }

  public struct StackIterator<E>: IteratorProtocol {
    public typealias Element = E

    private var current: Node<E>?

    fileprivate init(_ first: Node<E>?) {
      self.current = first
    }

    public mutating func next() -> E? {
      if let item = current?.item {
        current = current?.next
        return item
      }
      return nil
    }
  }

  public init() {}

  public func isEmpty() -> Bool {
    return self.count == 0
  }

  public func peek() -> E? {
    return self.first?.item
  }

  public func makeIterator() -> StackIterator<E> {
    return StackIterator<E>(self.first)
  }

  public func push(item: E) {
    let oldFirst = self.first
    self.first = Node<E>(item: item, next: oldFirst)
    count += 1
  }

  public func pop() -> E? {
    if self.isEmpty() {
      fatalError("Stack is no existing.")
    }
    let firstItem = self.first?.item
    self.first = first?.next
    count -= 1
    return firstItem
  }

}

extension Stack: CustomStringConvertible {
  public var description: String {
    return self.reduce(into: "") { $0 += "\($1), " }
  }
}
