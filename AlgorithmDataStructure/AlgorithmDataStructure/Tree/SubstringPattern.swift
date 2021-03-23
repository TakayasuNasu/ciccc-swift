//
//  SubstringPattern.swift
//  AlgorithmDataStructure
//
//  Created by Takayasu Nasu on 2021/03/19.
//

import Foundation

func BMSerch() {

  func createTable(_ pattern: String) -> Dictionary<Character, Int> {

    var table = Dictionary<Character, Int>()

    for i in 0..<pattern.count {
      table[Character(pattern[i])] = pattern.count - i - 1
    }

    return table

  }

  func originalSubstring(_ text: String, _ pattern: String) {

    let table = createTable(pattern)

    var i = pattern.count - 1
    var j = pattern.count - 1

    while i < text.count {
      if text[i] != pattern[j] {
        if let number = table[Character(text[i])] {
          i += number
        } else {
          i += pattern.count - 1
        }
        j = pattern.count - 1
      } else {
        if j == 1 {
          print(text[i - 1, i + pattern.count])
          break
        }
        i -= 1
        j -= 1
      }
    }
  }

  let text = "I am honored to be with you today at your commencement from one of the finest universities in the world. I never graduated from college. Truth be told, this is the closest I’ve ever gotten to a college graduation. Today I want to tell you three stories from my life. That’s it. No big deal. Just three stories."

  let pattern = "Today"

  originalSubstring(text, pattern)
}
