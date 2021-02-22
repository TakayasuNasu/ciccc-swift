//
//  ManagedToDo.swift
//  SimpleToDoWithCoreData
//
//  Created by Takayasu Nasu on 2021/02/20.
//

import Foundation
import CoreData

class ManagedToDo: NSManagedObject, Model {

  let container: NSPersistentContainer = AppDelegate.persistentContainer

  func saveContext() {
    let context = self.container.viewContext
    do {
      try context.save()
    } catch {
      fatalError("Couldn't save todo!!")
    }
  }
}
