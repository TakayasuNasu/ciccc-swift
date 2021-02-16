//
//  UserCount.swift
//  Habits
//
//  Created by Takayasu Nasu on 2021/02/14.
//

import Foundation

struct UserCount {
  let user: User
  let count: Int
}

extension UserCount: Codable {}

extension UserCount: Hashable {}
