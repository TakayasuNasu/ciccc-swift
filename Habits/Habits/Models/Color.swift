//
//  Color.swift
//  Habits
//
//  Created by Takayasu Nasu on 2021/02/13.
//

import Foundation

struct Color {
  let hue: Double
  let saturation: Double
  let brighness: Double
}

extension Color: Codable {
  enum CodingKeys: String, CodingKey {
    case hue = "h"
    case saturation = "e"
    case brighness = "b"
  }
}
