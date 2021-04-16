//
//  main.swift
//  MinimumCostFlow
//
//  Created by Takayasu Nasu on 2021/04/13.
//

import Foundation

public struct IndexPriorityQueue<Key: Comparable & Hashable> {
  /// the array that stores the heap's nodes
  private(set) var elements = [Key]()
  /// determines whether this is a max-heap(>) or min-heap(<)
  private var order: (Key, Key) -> Bool
  /// dictionary from elements to its heap position(index) in the `elements` array
  private var indices = [Key: Int]()

  /// Returns true if this priority queue is empty
  public var isEmpty: Bool {
    return elements.isEmpty
  }

  /// Returns the number of keys on this priority queue.
  public var count: Int {
    return elements.count
  }

  /// Returns the min or max key O(1)
  public var peek: Key? {
    return elements.first
  }

  /// Initializes an empty indexed priority queue with indices
  /// - Parameter order: order of priority queue (`min <` or `max >`)
  public init(_ order: @escaping (Key, Key) -> Bool) {
    self.order = order
  }

  /// Returns the index of the given key element. (amortized constant time **O(1)**)
  /// - Parameter key: key element
  /// - Returns: the index of the given key element
  public func index(of key: Key) -> Int? {
    return indices[key]
  }

  /// Is `key` on this priority queue? **O(1)**
  /// - Parameter key: key element
  /// - Returns: `true` if key exists on this priority queue; `false` otherwise.
  public func contains(key: Key) -> Bool {
    return indices[key] != nil
  }

  /// Enqueue key element on this priority queue. **O (log N)**
  /// - Parameter key: key element
  public mutating func enqueue(_ key: Key) {
    guard !contains(key: key) else { return }
    elements.append(key)
    indices[key] = elements.count - 1
    siftUp(from: elements.count - 1)
  }

  /// Dequeue the root node on this priority queue. **O(log N)**
  /// - Returns: the root node if the priority queue is not empty
  @discardableResult
  public mutating func dequeue() -> Key? {
    if isEmpty { return nil }
    let peek = self.peek!
    swapAt(0, count - 1)
    elements.remove(at: count - 1)
    indices[peek] = nil
    siftDown(from: 0)
    return peek
  }

  /// Update the old key to the new key value. **O(log N)**
  /// - Parameters:
  ///   - oldKey: old key
  ///   - newKey: new key
  public mutating func update(oldKey: Key, to newKey: Key) {
    guard let index = indices[oldKey] else { return }
    elements[index] = newKey
    siftDown(from: index)
    siftUp(from: index)
  }

  /// Delete the key at index `i` in this priority queue. **O(log N)**
  /// - Parameter i: index of the key to delete
  public mutating func delete(at i: Int) {
    swapAt(i, count - 1)
    elements.remove(at: count - 1)
    indices[elements[i]] = nil
    siftUp(from: i)
    siftDown(from: i)
  }

  /**
   Private helper methods
   */
  private mutating func siftUp(from i: Int) {
    var i = i
    while i > 0 && order(elements[parent(of: i)], elements[i]) {
      swapAt(parent(of: i), i)
      i = parent(of: i)
    }
  }

  private mutating func siftDown(from i: Int) {
    var i = i
    while left(of: i) < count {
      var j = left(of: i)
      if j < count - 1 && order(elements[j], elements[j + 1]) {
        j += 1
      }
      if !order(elements[i], elements[j]) { break }
      swapAt(i, j)
      i = j
    }
  }

  private mutating func swapAt(_ i: Int, _ j: Int) {
    elements.swapAt(i, j)
    indices[elements[i]] = i
    indices[elements[j]] = j
  }

  @inline(__always) private func parent(of index: Int) -> Int {
    return (index - 1) / 2
  }

  @inline(__always) private func left(of index: Int) -> Int {
    return 2 * index + 1
  }

  @inline(__always) private func right(of index: Int) -> Int {
    return 2 * index + 2
  }
}


struct CompEdge {
  var v: Int
  var w: Int
  var isActivate: Bool = true
}

extension CompEdge: Comparable {
  static func < (lhs: CompEdge, rhs: CompEdge) -> Bool {
    if lhs.w != rhs.w {
      return lhs.w < rhs.w
    } else {
      return lhs.isActivate
    }
  }
}

extension CompEdge: Hashable {}

func minimumCostFlow(_ input: [String]? = nil) -> Int {

  func prim(_ graph: [[(v: Int, w: Int, isActive: Bool)]], _ enhancer: Int) -> Int {
    let n = graph.count
    var mstEdges = [CompEdge]()
    var pq = IndexPriorityQueue<CompEdge>(>)
    var visited = [Bool](repeating: false, count: n)
    var days = 0
    visited[0] = true

    for edge in graph[0] {
      pq.enqueue(CompEdge(v: edge.v, w: edge.w, isActivate: edge.isActive))
    }

    while let edge = pq.dequeue() {
      if !visited[edge.v - 1] {
        visited[edge.v - 1] = true
        mstEdges.append(edge)
        if !edge.isActivate {
          days += 1
        }
        for e in graph[edge.v - 1] {
          pq.enqueue(CompEdge(v: e.v, w: e.w, isActivate: e.isActive))
        }
      }

//      if visited.count - visited.filter({ $0 }).count == 1 {
//        for _ in 0..<pq.count {
//          if let e = pq.dequeue() {
//            pq.enqueue(CompEdge(v: e.v, w: e.w - enhancer, isActivate: e.isActivate))
//          }
//        }
//      }


    }
    return days

  }


  func makeGraphe(_ activePipeNum: Int, _ n: Int, _ m: Int, _ input: [String]? = nil) -> [[(v:Int,w:Int,isActive:Bool)]] {
    var graph = [[(v:Int,w:Int, isActive: Bool)]](repeating: [(v: Int, w: Int, isActive: Bool)](), count: n)
    var isActive = true
    for i in 0..<m {
      if i >= activePipeNum {
        isActive = false
      }
      let edge = input == nil ? readLine()!.split(separator: " ").map { Int($0)! } : input![i + 1].split(separator: " ").map { Int($0)! }
      let u = edge[0]
      let v = edge[1]
      let w = edge[2]

      graph[u - 1].append((v:v, w:w, isActive: isActive))
      graph[v - 1].append((v:u, w:w, isActive: isActive))
    }

    return graph
  }

  let firstLine = input == nil ? readLine()!.split(separator: " ").map { Int($0)! } : input![0].split(separator: " ").map { Int($0)! }
  let graph = makeGraphe(firstLine[0] - 1, firstLine[0], firstLine[1], input)
  let result = prim(graph, firstLine[2])
  return result

}

func minimumCostFlowWithFileManeger() {
  let fileManager = FileManager()
  let testDirectory = "/Users/taka/Downloads/mcf"

  if let paths = try? fileManager.contentsOfDirectory(atPath: testDirectory).sorted() {
    let fileNum = paths.count
    var i = 0
    while i < fileNum{
      let inputURL = URL(fileURLWithPath: testDirectory + "/" + paths[i])
      let inputFile = try? String(contentsOf: inputURL, encoding: .utf8)
      let inputLines = inputFile!.split(separator:"\n").map {String($0)}

      let outputURL = URL(fileURLWithPath: testDirectory + "/" + paths[i + 1])
      let outputFile = try? String(contentsOf: outputURL, encoding: .utf8)
      let outputLines = outputFile!.split(separator:"\n").map {Int($0)!}

      let result = minimumCostFlow(inputLines)

      let answer = Int(outputLines.first!)
      if result == answer {
        print("Test\(paths[i]): pass! ms")
      } else {
        print("Test\(paths[i]): failed...")
        print("Your answer is \(result), whereas true output is \(answer)")
      }
      i += 2

    }
  }
}

print(minimumCostFlow())
//minimumCostFlowWithFileManeger()
