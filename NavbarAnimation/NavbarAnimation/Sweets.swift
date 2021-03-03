//
//  Sweets.swift
//  NavbarAnimation
//
//  Created by Takayasu Nasu on 2021/03/01.
//

import Foundation

protocol Model {
  var id: Int { get }
  var name: String { get }
}

struct Sweet: Model {
  var id: Int
  var name: String
}

struct Sweets {
  let items: [Sweet] = [
    Sweet(id: 1, name: "oreos"),
    Sweet(id: 2, name: "pizza_pockets"),
    Sweet(id: 3, name: "pop_tarts"),
    Sweet(id: 4, name: "popsicle"),
    Sweet(id: 5, name: "ramen")
  ]
}
