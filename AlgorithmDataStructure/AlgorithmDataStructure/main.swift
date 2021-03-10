//
//  main.swift
//  AlgorithmDataStructure
//
//  Created by Takayasu Nasu on 2021/03/09.
//

import Foundation

//printBinary(12)
//reverseLines(2)

let expressions = [
  "7",
  "(2+2)",
  "(1+(2*4))",
  "((1+3)+((1+2)*5))"
]

expressions.forEach { expression in
  evaluate(expression)
}
