//
//  UserStatistics.swift
//  Habits
//
//  Created by Takayasu Nasu on 2021/02/15.
//

import Foundation

struct UserStatistics {
  let user: User
  let habitCounts: [HabitCount]
}

extension UserStatistics: Codable {}
