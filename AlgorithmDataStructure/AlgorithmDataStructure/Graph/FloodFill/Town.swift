//
//  Town.swift
//  AlgorithmDataStructure
//
//  Created by Takayasu Nasu on 2021/03/24.
//

import Foundation

func town() {
  struct Square {
    let x: Int
    let y: Int
  }
  
  let dx = [0, 0, 1, -1]
  let dy = [1, -1, 0, 0]
  
  var townMap = [[Int]]()
  var coloredMap = [[Int]](repeating: [Int](repeating: 0, count: 25), count: 25)
  var houses = [Int](repeating: 0, count: 25 * 25) // the number of houses for each town (index)
  
  let n = Int(readLine()!)!
  for _ in 0..<n {
    let row = readLine()!.map { Int(String($0))! }
    townMap.append(row)
  }
  
  func bfs(square: Square, id: Int) {
    let q = Queue<Square>()
    q.enqueue(item: square)
    coloredMap[square.x][square.y] = id
    houses[id] += 1
    
    while !q.isEmpty() {
      let sq = q.dequeue()!
      let x = sq.x
      let y = sq.y
      for i in 0..<4 {
        let nx = x + dx[i]
        let ny = y + dy[i]
        // check the bounds
        if nx >= 0 && nx < n && ny >= 0 && ny < n {
          if (townMap[nx][ny] == 1 && coloredMap[nx][ny] == 0) { // check if there's a house
            q.enqueue(item: Square(x: nx, y: ny))
            coloredMap[nx][ny] = id
            houses[id] += 1
          }
        }
      }
    }
  }
  
  var id = 0
  for x in 0..<n {
    for y in 0..<n {
      if townMap[x][y] == 1 && coloredMap[x][y] == 0 {
        id += 1
        bfs(square: Square(x: x, y: y), id: id)
      }
    }
  }
  
  print(id) // the number of towns
  houses = Array(houses[1...id]) // getting the sub array from index 1 to id
  houses.sort()
  for num in houses {
    print(num) // the number of houses per town
  }
}


