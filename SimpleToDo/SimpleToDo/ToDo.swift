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

}

let defaultData: ToDoList = {
  let highPriorities = [ToDo(title: "hoge", priority: 1, isCompleted: false)]
  let mediumPriorities = [ToDo(title: "fuga", priority: 2, isCompleted: false)]
  let lowPriorities = [ToDo(title: "piyo", priority: 3, isCompleted: false)]
  let todoList = ToDoList(highPriorities: highPriorities, mediumPriorities: mediumPriorities, lowPriorities: lowPriorities)
  return todoList
}()
