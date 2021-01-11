//
//  ToDoDataSource.swift
//  SimpleToDo
//
//  Created by 那須毅康 on 2021/01/09.
//

import UIKit

class ToDoDataSource: NSObject, UITableViewDataSource {

  let cellId = "ToDoCell"
  let headers = ["High Priorities", "Medium Priorities", "Low Priorities"]

  var model: ToDoList = defaultData

  func setUpModel(_ model: ToDoList) {
    self.model = model
  }

  func numberOfSections(in tableView: UITableView) -> Int {
    return self.headers.count
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.model.getList(at: section).count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
    let list = self.model.getList(at: indexPath.section)
    cell.textLabel?.text = list[indexPath.row].title
    cell.accessoryType = .detailDisclosureButton
    return cell
  }

  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    self.headers[section]
  }

  func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
    return true
  }

  func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    let todo: ToDo = self.model.remove(at: sourceIndexPath)
    self.model.insert(at: destinationIndexPath, with: todo)
  }


}
