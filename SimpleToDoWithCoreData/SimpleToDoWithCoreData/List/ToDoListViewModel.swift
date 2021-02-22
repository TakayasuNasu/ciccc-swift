//
//  IndexVewModel.swift
//  SimpleToDoWithCoreData
//
//  Created by Takayasu Nasu on 2021/02/20.
//

import Foundation
import CoreData

class ToDoListViewModel {

  let todo: ManagedToDo

  let container: NSPersistentContainer = AppDelegate.persistentContainer

  var fetchedResultsController: NSFetchedResultsController<ManagedToDo>

  init() {
    self.todo = ManagedToDo(context: self.container.viewContext)
    let fetchedResultsControllerCreator = FetchedResultsControllerCreator()
    let fetchRequest:NSFetchRequest<ManagedToDo> = ManagedToDo.fetchRequest()
    fetchRequest.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true, selector: #selector(NSString.localizedCaseInsensitiveCompare(_:)))]
    self.fetchedResultsController = fetchedResultsControllerCreator.execute(managed: todo, fetchRequest: fetchRequest)
  }


}
