//
//  ToDoMutationDelegate.swift
//  SimpleToDo
//
//  Created by 那須毅康 on 2021/01/10.
//

import Foundation

protocol ToDoMutationDelegate: class {
  func add(_ todo: ToDo)
  func edit(_ todo: ToDo)
}
