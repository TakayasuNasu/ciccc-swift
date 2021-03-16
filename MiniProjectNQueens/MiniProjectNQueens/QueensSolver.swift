//
//  QueensSolver.swift
//  SwiftAGDS
//
//  Created by Derrick Park on 2019-03-13.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import Foundation

/// Write a function solveQueens that accepts a Board as a parameter
/// and tries to place 8 queens on it safely.
///
/// - Your method should stop exploring if it finds a solution
/// - You are allowed to change the function header (args or return type)
/// - Your total recursive calls should not exceed 120 times.

var count = 0
var find = false
func solve8Queens(board: inout Board, row: Int, col: Int, queen: Int = 0) {
  if !find {
    count += 1
  }
  if queen == board.size {
    print(board)
    find = true
  }

  for i in col..<board.size {
    if board.isSafe(row: row, col: col + i) {
      board.place(row: row, col: col + i)
      solve8Queens(board: &board, row: row + 1, col: col, queen: queen + 1)
      board.remove(row: row, col: col + i)
    }
  }
  

}

