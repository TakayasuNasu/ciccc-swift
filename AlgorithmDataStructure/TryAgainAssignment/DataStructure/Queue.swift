//
//  Queue.swift
//  TryAgainAssignment
//
//  Created by Takayasu Nasu on 2021/04/22.
//

import Foundation


public final class Queue<E>: Sequence {

  private var first: Node<E>? = nil
  private var last: Node<E>? = nil
  private(set) var count: Int = 0

  fileprivate class Node<E> {

    fileprivate var item: E
    fileprivate var next: Node<E>?

    fileprivate init(item: E, next: Node<E>? = nil) {
      self.item = item
      self.next = next
    }
  }

  public struct QueueIterator<E>: IteratorProtocol {
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

  public func makeIterator() -> QueueIterator<E> {
    return QueueIterator<E>(self.first)
  }

  public func enqueue(item: E) {
    let oldLast = self.last
    self.last = Node<E>(item: item, next: nil)
    if self.isEmpty() {
      self.first = last
    } else {
      oldLast?.next = last
    }
    count += 1
  }

  public func dequeue() -> E? {
    if self.isEmpty() {
      fatalError("Queue is no existing.")
    }
    let firstItem = self.first?.item
    self.first = first?.next
    count -= 1
    if self.isEmpty() {
      self.last = nil
    }
    return firstItem
  }

}

extension Queue: CustomStringConvertible {
  public var description: String {
    return self.reduce(into: "") { $0 += "\($1), " }
  }
}
