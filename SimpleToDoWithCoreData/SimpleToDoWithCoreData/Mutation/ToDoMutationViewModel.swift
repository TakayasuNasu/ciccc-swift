//
//  EditViewModel.swift
//  SimpleToDoWithCoreData
//
//  Created by Takayasu Nasu on 2021/02/20.
//

import Foundation
import CoreData
import Combine
import CombineCocoa

class ToDoMutationViewModel {

  let container: NSPersistentContainer = AppDelegate.persistentContainer

  var subscriptions = Set<AnyCancellable>()

  let todo: ManagedToDo

  var todoTitle: String = ""

  var fetchedResultsController: NSFetchedResultsController<ManagedToDo>

  init() {
    self.todo = ManagedToDo(context: self.container.viewContext)
    let fetchedResultsControllerCreator = FetchedResultsControllerCreator()
    let fetchRequest:NSFetchRequest<ManagedToDo> = ManagedToDo.fetchRequest()
    fetchRequest.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true, selector: #selector(NSString.localizedCaseInsensitiveCompare(_:)))]
    self.fetchedResultsController = fetchedResultsControllerCreator.execute(managed: self.todo, fetchRequest: fetchRequest)

  }

  func save() {
    self.todo.title = self.todoTitle
    self.todo.saveContext()
  }

  func update() {
    // ボタンが押されたら更新
  }
}
