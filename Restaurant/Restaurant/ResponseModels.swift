//
//  ResponseModels.swift
//  Restaurant
//
//  Created by Takayasu Nasu on 2021/01/21.
//

import Foundation

struct MenuResponse: Codable {
  let items: [MenuItem]
}

struct CategoriesResponse: Codable {
  let categories: [String]
}

struct OrderResponse: Codable {
  let prepTime: Int

  enum CodingKeys: String, CodingKey {
    case prepTime = "preparation_time"
  }
}
