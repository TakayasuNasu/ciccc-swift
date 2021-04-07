//
//  CourseSchedule.swift
//  AlgorithmDataStructure
//
//  Created by Takayasu Nasu on 2021/04/06.
//

import Foundation

func courseSchedule() {

  func canFinish(_ numCourses: Int, _ prerequisites: [[Int]]) -> Bool {
    let q = Queue<Int>()
    var adjList = [[Int]](repeatElement([Int](repeatElement(0, count: numCourses)), count: numCourses))
    var inDegree = [Int](repeating: 0, count: numCourses)
    var count = 0

    for i in 0..<prerequisites.count {
      let col = prerequisites[i][0]
      let row = prerequisites[i][1]
      if adjList[row][col] == 0  {
        inDegree[col] += 1
      }
      adjList[row][col] = 1
    }

    for i in 0..<inDegree.count {
      if inDegree[i] == 0 {
        q.enqueue(item: i)
      }
    }

    while !q.isEmpty() {
      let row = q.dequeue()!
      count += 1
      for i in 0..<numCourses {
        if adjList[row][i] != 0 {
          inDegree[i] -= 1
          if inDegree[i] == 0 {
            q.enqueue(item: i)
          }
        }
      }
    }
    return numCourses == count
  }

  let firstLine = readLine()!.split(separator: " ").map { Int($0)! }
  let numCourses = firstLine[0]
  var prerequisites = [[Int]](repeating: [Int](repeating: 0, count: 2), count: firstLine[1])

  for i in 0..<firstLine[1] {
    prerequisites[i] = readLine()!.split(separator: " ").map { Int($0)! }
  }

  let result = canFinish(numCourses, prerequisites)
  print(result)
  
  

}



