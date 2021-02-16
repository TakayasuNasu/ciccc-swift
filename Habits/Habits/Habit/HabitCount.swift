//
//  HabitCount.swift
//  Habits
//
//  Created by Takayasu Nasu on 2021/02/15.
//

import Foundation

struct HabitCount {
  let habit: Habit
  let count: Int
}

extension HabitCount: Codable {}

extension HabitCount: Hashable {}

extension HabitCount: Comparable {
  static func < (lhs: HabitCount, rhs: HabitCount) -> Bool {
    return lhs.habit < rhs.habit
  }

}
