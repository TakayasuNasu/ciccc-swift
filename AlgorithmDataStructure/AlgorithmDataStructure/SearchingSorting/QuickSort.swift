//
//  QuickSort.swift
//  AlgorithmDataStructure
//
//  Created by Takayasu Nasu on 2021/03/12.
//

import Foundation

func quickSort<T: Comparable>(_ arr: [T], _ comparator: (T, T) -> Bool) -> [T] {
  guard arr.count > 1 else { return arr }
  let elements = arr

  let pivot = elements[0]
  var left: [T] = []
  var right: [T] = []

  for (i, item) in elements.enumerated() {
    guard i != 0 else { continue }
    if comparator(item, pivot) {
      left.append(item)
    } else {
      right.append(item)
    }
  }

  left = quickSort(left, comparator)
  right = quickSort(right, comparator)

  return left + [pivot] + right
}
