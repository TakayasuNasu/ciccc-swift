//
//  main.swift
//  AlgorithmDataStructure
//
//  Created by Takayasu Nasu on 2021/03/09.
//

import Foundation

//printBinary(12)
//reverseLines(2)

//let expressions = [
//  "7",
//  "(2+2)",
//  "(1+(2*4))",
//  "((1+3)+((1+2)*5))"
//]
//
//expressions.forEach { expression in
//  evaluate(expression)
//}

// func rollDiceSum(n: Int, desiredSum: Int)
//rollDiceSum(n: 2, desiredSum: 4)
//rollDiceSumNoDuplicate(n: 3, desiredSum: 12)
//let sortedList = quickSort([8,2,10,6,5,7,1,9,4,11,3], { $0 <= $1 })
//print(sortedList)

//treeTraversalForTreeQuize()
//diameterForTreeQuize()
//BMSerch()
//lowestCommonAncestor()
//var uf = UF(12)
//uf.union(4, 5)
//let parents = uf.find(3)
//print(parents)
//cyclicPermutation()
//repeatingSequence()
//sushiRestaurant()
//sushiRestaurantForCheck()
//tomatoFarm()
//bridges()
//sushiSolution()
//courseSchedule()
//courseScheduleSecond()
//twoCityScheduling()
//taskScheduler()
//gasStation()
partitionLabels()





extension String {
  subscript(index: Int) -> String {
    get {
      return String(self[self.index(startIndex, offsetBy: index)])
    }
    set {
      let startIndex = self.index(self.startIndex, offsetBy: index)
      self = self.replacingCharacters(in: startIndex..<self.index(after: startIndex), with: newValue)
    }
  }

  subscript(start: Int, end: Int) -> String {
    get {
      let startIndex = self.index(self.startIndex, offsetBy: start)
      let endIndex = self.index(self.startIndex, offsetBy: end)
      return String(self[startIndex..<endIndex])
    }
    set {
      let startIndex = self.index(self.startIndex, offsetBy: start)
      let endIndex = self.index(self.startIndex, offsetBy: end)
      self = self.replacingCharacters(in: startIndex..<endIndex, with: newValue)
    }
  }
}
