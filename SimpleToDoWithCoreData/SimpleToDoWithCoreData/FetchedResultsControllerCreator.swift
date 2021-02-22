//
//  FetchedResultsControllerCreator.swift
//  SimpleToDoWithCoreData
//
//  Created by Takayasu Nasu on 2021/02/20.
//

import Foundation
import CoreData

class FetchedResultsControllerCreator: NSObject, NSFetchedResultsControllerDelegate {

  func execute<Object>(managed object: Object, fetchRequest: NSFetchRequest<Object>) -> NSFetchedResultsController<Object>  where Object : NSManagedObject {
    let container: NSPersistentContainer = AppDelegate.persistentContainer
    let fetchedResultsController = NSFetchedResultsController<Object>(
      fetchRequest: fetchRequest,
      managedObjectContext: container.viewContext,
      sectionNameKeyPath: nil,
      cacheName: nil)

    fetchedResultsController.delegate = self
    try! fetchedResultsController.performFetch()
    return fetchedResultsController
  }
}
