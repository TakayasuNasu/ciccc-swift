//
//  Queue.swift
//  AlgorithmDataStructure
//
//  Created by Takayasu Nasu on 2021/03/15.
//

import Foundation

public final class Bag<E>: Sequence {

  private var first: Node<E>? = nil

  // getter is public, setter is private.
  private(set) var count: Int = 0

  fileprivate class Node<E> {

    fileprivate var item: E
    fileprivate var next: Node<E>?

    fileprivate init(item: E, next: Node<E>? = nil) {
      self.item = item
      self.next = next
    }
  }

  public init() {

  }

  public func isEmpty() -> Bool {
    return self.count == 0
  }

  public func add(item: E) {
    let oldFirst = first
    first = Node<E>(item: item, next: oldFirst)
    count += 1
  }

  public struct BagIterator<E> : IteratorProtocol {
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

  public func makeIterator() -> BagIterator<E> {
    return BagIterator<E>(first)
  }

}

extension Bag: CustomStringConvertible {
  public var description: String {
    return self.reduce(into: "") { $0 += "\($1), " }
  }
}
