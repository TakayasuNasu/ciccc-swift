//
//  Game.swift
//  ApplePie
//
//  Created by 那須毅康 on 2020/12/09.
//

import Foundation

struct Game {
  var word: String
  var incorrectMovesRemaining: Int
  var guessedLetters: [Character]
  var formattedWord: String {
    var guessedWord = ""
    for letter in self.word {
      if guessedLetters.contains(letter) {
        guessedWord += "\(letter)"
      } else {
        guessedWord += "_"
      }
    }
    return guessedWord
  }

  mutating func playerGuessed(letter: Character) {
    self.guessedLetters.append(letter)
    if !self.word.contains(letter) { self.incorrectMovesRemaining -= 1 }
  }
}
