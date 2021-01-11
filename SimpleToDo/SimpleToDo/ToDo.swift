//
//  ToDo.swift
//  SimpleToDo
//
//  Created by 那須毅康 on 2021/01/09.
//

import Foundation

protocol DataSourceModel {
  var title: String { get }
}

struct ToDo: DataSourceModel {
  var title: String
  var priority: Int
  var isCompleted: Bool
}

struct ToDoList {
  var highPriorities: [ToDo]
  var mediumPriorities: [ToDo]
  var lowPriorities: [ToDo]

  func getList(at section: Int) -> [ToDo]{
    return {
      switch section {
      case 0:
        return self.highPriorities
      case 1:
        return self.mediumPriorities
      case 2:
        return self.lowPriorities
      default:
        return self.highPriorities
      }
    }()
  }

  func find(by path: IndexPath) -> ToDo {
    let list = self.getList(at: path.section)
    return list[path.row]
  }

  @discardableResult
  mutating func remove(at path: IndexPath) -> ToDo {
    return {
      switch path.section {
      case 0:
        return highPriorities.remove(at: path.row)
      case 1:
        return mediumPriorities.remove(at: path.row)
      case 2:
        return lowPriorities.remove(at: path.row)
      default:
        return highPriorities.remove(at: path.row)
      }
    }()
  }

  mutating func insert(at path: IndexPath, with todo: ToDo) {
    switch path.section {
    case 0:
      highPriorities.insert(todo, at: path.row)
    case 1:
      mediumPriorities.insert(todo, at: path.row)
    case 2:
      lowPriorities.insert(todo, at: path.row)
    default:
      highPriorities.insert(todo, at: path.row)
    }
  }

}

let defaultData: ToDoList = {
  let highPriorities = [ToDo(title: "Find Job", priority: 1, isCompleted: false)]
  let mediumPriorities = [ToDo(title: "Study about Swift", priority: 2, isCompleted: false)]
  let lowPriorities = [ToDo(title: "Prepare to Move", priority: 3, isCompleted: false)]
  let todoList = ToDoList(highPriorities: highPriorities, mediumPriorities: mediumPriorities, lowPriorities: lowPriorities)
  return todoList
}()
