//
//  Bridges.swift
//  AlgorithmDataStructure
//
//  Created by Takayasu Nasu on 2021/04/03.
//

import Foundation

func bridges() {

  struct Square {
    let x: Int
    let y: Int
  }

  let dx = [0, 0, 1, -1]
  let dy = [1, -1, 0, 0]

  var bridgeGirder: [Square] = []
  var result: [Int] = [10000]


  func bfs(square: Square,  _ continent: inout [[Int]]) {
    let q = Queue<Square>()
    q.enqueue(item: square)

    while !q.isEmpty() {
      let sq = q.dequeue()!
      let x = sq.x
      let y = sq.y
      for i in 0..<4 {
        let nx = x + dx[i]
        let ny = y + dy[i]
        if nx >= 0 && ny >= 0 && nx < continent[0].count && ny < continent.count {
          if continent[ny][nx] == 2 {
            q.enqueue(item: Square(x: nx, y: ny))
            continent[ny][nx] = 1
          }
        }
      }
    }
  }

  func dfs(square: Square, _ continent: inout [[Int]], _ stack: inout [[Bool]]) {
    if result.min()! <= bridgeGirder.count { return }
    stack[square.y][square.x] = true
    for i in 0..<4 {
      let nx = square.x + dx[i]
      let ny = square.y + dy[i]
      if nx < 0 || ny < 0 || nx >= continent[0].count || ny >= continent.count { continue }
      if stack[ny][nx] { continue }
      if continent[ny][nx] == 0 {
        bridgeGirder.append(Square(x: nx, y: ny))
        dfs(square: Square(x: nx, y: ny), &continent, &stack)
        stack[ny][nx] = false
        bridgeGirder.removeLast()
      }
      if continent[ny][nx] == 2 {
        result.append(bridgeGirder.count)
      }
    }
  }

  func checkIsland(square: Square, _ continent: inout [[Int]]) {
    continent[square.y][square.x] = 2
    for i in 0..<4 {
      let nx = square.x + dx[i]
      let ny = square.y + dy[i]
      if nx < 0 || ny < 0 || nx >= continent[0].count {
        continent[square.y][square.x] = 1
      }
    }
  }

  func makeMap(_ rowNum: Int) -> [[Int]] {
    var tomatoBox = [[Int]]()
    for _ in 0..<rowNum {
      let row = readLine()!.split(separator: " ").map { Int($0)! }
      tomatoBox.append(row)
    }
    return tomatoBox
  }

  let mapSize = Int(readLine()!)!
  let islandMap = makeMap(mapSize)

  var continent = [[Int]](repeating: [Int](repeating: 0, count: mapSize), count: mapSize)

  for i in 0..<mapSize {
    for j in 0..<mapSize {
      if islandMap[i][j] == 1 {
        checkIsland(square: Square(x:j,y:i), &continent)
      }
    }
  }

  for i in 0..<mapSize {
    for j in 0..<mapSize {
      if continent[i][j] == 1 {
        bfs(square: Square(x:j,y:i), &continent)
      }
    }
  }

  var stack = [[Bool]](repeating: [Bool](repeating: false, count: mapSize), count: mapSize)

  for i in 0..<mapSize {
    for j in 0..<mapSize {
      if continent[i][j] == 1 {
        dfs(square: Square(x: j, y: i), &continent, &stack)
        bridgeGirder.removeAll()
        stack = [[Bool]](repeating: [Bool](repeating: false, count: mapSize), count: mapSize)
      }
    }
  }

  print(result.min()!)

}
