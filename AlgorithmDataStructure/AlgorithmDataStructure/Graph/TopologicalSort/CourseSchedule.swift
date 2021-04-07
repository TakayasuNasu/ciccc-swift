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
    var adjList = [[Int]](repeating: [Int](repeating: 0, count: numCourses), count: numCourses)
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

  // input example
  //  2 2
  //  1 0
  //  0 1
  let firstLine = readLine()!.split(separator: " ").map { Int($0)! }
  let numCourses = firstLine[0]
  var prerequisites = [[Int]](repeating: [Int](repeating: 0, count: 2), count: firstLine[1])

  for i in 0..<firstLine[1] {
    prerequisites[i] = readLine()!.split(separator: " ").map { Int($0)! }
  }

  let result = canFinish(numCourses, prerequisites)
  print(result)

}



func courseScheduleSecond() {

  func findOrder(_ numCourses: Int, _ prerequisites: [[Int]]) -> [Int] {
    if numCourses == 0 {
      return []
    }

    let q = Queue<Int>()
    var result = [Int](repeating: 0, count: numCourses)
    var inDegree = [Int](repeating: 0, count: numCourses)
    var index = 0

    for i in 0..<prerequisites.count {
      inDegree[prerequisites[i][0]] += 1
    }

    for i in 0..<numCourses {
      if inDegree[i] == 0 {
        result[index] = i
        index += 1
        q.enqueue(item: i)
      }
    }
    while !q.isEmpty() {
      let row = q.dequeue()!
      for i in 0..<prerequisites.count {
        if prerequisites[i][1] == row {
          inDegree[prerequisites[i][0]] -= 1
          if inDegree[prerequisites[i][0]] == 0 {
            result[index] = prerequisites[i][0]
            index += 1
            q.enqueue(item: prerequisites[i][0])
          }
        }
      }
    }

    return (index == numCourses) ? result : []
  }

  // input example
  //  4 4
  //  1 0
  //  2 0
  //  3 1
  //  3 2
  let firstLine = readLine()!.split(separator: " ").map { Int($0)! }
  let numCourses = firstLine[0]
  var prerequisites = [[Int]](repeating: [Int](repeating: 0, count: 2), count: firstLine[1])

  for i in 0..<firstLine[1] {
    prerequisites[i] = readLine()!.split(separator: " ").map { Int($0)! }
  }

  let result = findOrder(numCourses, prerequisites)
  print(result)
}
