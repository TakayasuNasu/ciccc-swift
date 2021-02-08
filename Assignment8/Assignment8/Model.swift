//
//  Model.swift
//  Assignment8
//
//  Created by Takayasu Nasu on 2021/02/05.
//

import Foundation
import RxSwift
import RxDataSources

protocol ModelProtocol {
  var id: Int { get }
  var name: String { get }
  var tags: [Int] { get }
  func all() -> [ModelProtocol]
}

extension ModelProtocol {
  var tags: [Int] {
    return []
  }
}

struct Cuisine: ModelProtocol, IdentifiableType, Equatable {

  typealias Identity = Int
  var identity: Int {
    return id
  }

  var id: Int = 1
  var name: String = ""
  var image: URL! = URL(string: "")
  var price: Int = 0
  var tags: [Int] = []

  func all() -> [ModelProtocol] {
    return Cuisines.data
  }
}

struct Tag: ModelProtocol, IdentifiableType, Equatable {

  typealias Identity = Int
  var identity: Int {
    return id
  }

  var id: Int = 1
  var name: String = ""

  func all() -> [ModelProtocol] {
    return Tags.data
  }
}
