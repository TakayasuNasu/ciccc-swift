//
//  File.swift
//  AlgorithmDataStructure
//
//  Created by Takayasu Nasu on 2021/03/10.
//

import Foundation

func permutationHelper(_ word: String, _ soFar: String = "") {
  if word.count == 0 {
    print(soFar)
  } else {
    for i in 0..<word.count {
      let c = word[i]
      permutationHelper(word[0, i] + word[i + 1, word.count], soFar + c)
    }
  }
}

func permutation(_ word: String) {

}
