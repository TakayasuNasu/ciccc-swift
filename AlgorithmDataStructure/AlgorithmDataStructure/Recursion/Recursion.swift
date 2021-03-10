//
//  Recursion.swift
//  AlgorithmDataStructure
//
//  Created by Takayasu Nasu on 2021/03/09.
//

import Foundation

func printBinary(_ n: Int) {
  if n < 0 {
    print("-", terminator: "") // print without newline
    printBinary(-n)
    print()
    return
  }
  // base case
  if n < 2 {
    print(n)
    return // stop
  }
  printBinary(n / 2)
  print(n % 2, terminator: "")
}

func reverseLines(_ line: Int) {
  let contents = try! String(
    contentsOfFile: "/Users/taka/Documents/workspace/swift_workspace/ciccc/AlgorithmDataStructure/AlgorithmDataStructure/Recursion/provinces.txt",
    encoding: .utf8
  )
  let lines = contents.split(separator: "\n")
  if line < lines.count {
    reverseLines(line + 1)
    print(lines[line])
  }

}
