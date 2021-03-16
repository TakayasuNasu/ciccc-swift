//
//  main.swift
//  MiniProjectNQueens
//
//  Created by Takayasu Nasu on 2021/03/15.
//

import Foundation


var board = Board(size: 8)
solve8Queens(board: &board, row: 0, col: 0)
print(count)
