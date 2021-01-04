//
//  Question.swift
//  PersonalityQuiz
//
//  Created by 那須毅康 on 2020/12/16.
//

import Foundation

struct Question {
  var text: String
  var type: ResponseType
  var answers: [Answer]
}

enum ResponseType {
  case single, multiple, ranged
}
