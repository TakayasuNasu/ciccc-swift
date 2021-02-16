//
//  HabitStatistics.swift
//  Habits
//
//  Created by Takayasu Nasu on 2021/02/14.
//

import Foundation

struct HabitStatistics {
  let habit: Habit
  let userCounts: [UserCount]
}

extension HabitStatistics: Codable {}
