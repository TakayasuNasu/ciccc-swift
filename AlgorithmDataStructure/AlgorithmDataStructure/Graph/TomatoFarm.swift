//
//  TomatoFarm.swift
//  AlgorithmDataStructure
//
//  Created by Takayasu Nasu on 2021/03/30.
//

import Foundation

func tomatoFarm() {

  struct Square {
    let x: Int
    let y: Int
    var day: Int = 0
  }

  let dx = [0, 0, 1, -1]
  let dy = [1, -1, 0, 0]

  func bfs(squares: [Square], _ box: inout [[Int]], _ count: inout Int) {
    let q = Queue<Square>()
    for square in squares {
      q.enqueue(item: square)
    }

    while !q.isEmpty() {
      let sq = q.dequeue()!
      let x = sq.x
      let y = sq.y
      count = sq.day
      for i in 0..<4 {
        let nx = x + dx[i]
        let ny = y + dy[i]
        if nx >= 0 && nx < box[0].count && ny >= 0 && ny < box.count {
          if box[ny][nx] == 0 {
            q.enqueue(item: Square(x: nx, y: ny, day: sq.day + 1))
            box[ny][nx] = 1
          }
        }
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

  let firstLine: [Int] = readLine()!.split(separator: " ").map { Int($0)! }
  let colNum = firstLine[0]
  let rowNum = firstLine[1]
  var tomatoBox = makeMap(rowNum)
  let tomatoBoxCopy = tomatoBox


  var count = 0
  var squares: [Square] = []
  for i in 0..<rowNum {
    for j in 0..<colNum {
      if tomatoBoxCopy[i][j] == 1 {
        squares.append(Square(x: j, y: i))
      }
    }
  }

  bfs(squares: squares, &tomatoBox, &count)

  print()

  for row in tomatoBox {
    for col in row {
      if col == 0 {
        count = -1
      }
    }
  }
  print(count)

}
