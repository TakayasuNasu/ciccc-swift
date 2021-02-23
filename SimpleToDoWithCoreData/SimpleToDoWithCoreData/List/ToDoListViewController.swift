//
//  ToDoListViewController.swift
//  SimpleToDoWithCoreData
//
//  Created by Takayasu Nasu on 2021/02/20.
//

import UIKit
import CoreData
import SnapKit

class ToDoListViewController: UIViewController {

  let viewModel: ToDoListViewModel = ToDoListViewModel()

  private var blocks:[() -> Void] = []

  lazy var addOrUpdateButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(toMutation))

  lazy var removeButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(removeToDo))

  let collectionView: UICollectionView = {
    let configuration = UICollectionLayoutListConfiguration(appearance: .sidebarPlain)
    let layout = UICollectionViewCompositionalLayout.list(using: configuration)
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.backgroundColor = .systemBackground
    collectionView.allowsMultipleSelection = true
    return collectionView
  }()

  // MARK: - Life Cycle Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    super.title = Titles.LIST
    super.view.backgroundColor = .systemBackground

    super.navigationItem.leftBarButtonItem = super.editButtonItem
    super.navigationItem.rightBarButtonItems = [self.addOrUpdateButton, self.removeButton]

    self.collectionView.register(ToDoListCell.self, forCellWithReuseIdentifier: ToDoListCell.reuseIdentifier)
    self.collectionView.dataSource = self
    self.collectionView.delegate = self

    self.viewModel.fetchedResultsController.delegate = self

    self.setUI()
  }

}

extension ToDoListViewController {

  private func setUI() {
    super.view.addSubview(self.collectionView)
    self.collectionView.snp.makeConstraints { (make) -> Void in
      make.top.bottom.equalTo(super.view.safeAreaLayoutGuide)
      make.leading.trailing.equalToSuperview()
    }
  }

  @objc private func toMutation() {
    let nextViewController = ToDoMutationViewController()
    super.navigationController?.pushViewController(nextViewController , animated: true)
  }

  @objc private func removeToDo() {
    if let indexList = self.collectionView.indexPathsForSelectedItems {
      for indexPath in indexList {
        let todo = self.viewModel.fetchedResultsController.object(at: indexPath)
        self.viewModel.fetchedResultsController.managedObjectContext.delete(todo)
      }
      do {
        try self.viewModel.fetchedResultsController.managedObjectContext.save()
      } catch {
        fatalError("Couldn't delete!!")
      }
    }
  }

}

extension ToDoListViewController: UICollectionViewDataSource, UICollectionViewDelegate {

  func numberOfSections(in collectionView: UICollectionView) -> Int {
    if let count = self.viewModel.fetchedResultsController.sections?.count {
      return count
    }
    return 0
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    guard let sections = self.viewModel.fetchedResultsController.sections else {
      fatalError("No sections in fetchedResultsController")
    }
    let sectionInfo = sections[section]
    return sectionInfo.numberOfObjects
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, ManagedToDo> { cell, indexPath, item in
      var content = cell.defaultContentConfiguration()
      content.text = item.title
      cell.accessories = [
        .disclosureIndicator(options: .init(tintColor: .systemGray)),
        .reorder()
      ]
      cell.contentConfiguration = content
    }
    let object = self.viewModel.fetchedResultsController.object(at: indexPath)
    let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: object)
    return cell
  }

  override func setEditing(_ editing: Bool, animated: Bool) {
    super.setEditing(editing, animated: animated)
    self.collectionView.isEditing = editing
  }

}

extension ToDoListViewController: NSFetchedResultsControllerDelegate {

  func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
    switch type {
    case .delete:
      blocks.append { [weak self] in
        self?.collectionView.deleteItems(at: [indexPath!])
      }
    case .insert:
      blocks.append  { [weak self] in
        self?.collectionView.insertItems(at: [newIndexPath!])
      }
    case .move:
      blocks.append { [weak self] in
        self?.collectionView.moveItem(at: indexPath!, to: newIndexPath!)
      }
    case .update:
      blocks.append { [weak self] in
        self?.collectionView.reloadItems(at: [indexPath!])
      }
    @unknown default:
      break
    }
  }

  func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    blocks.removeAll()
  }

  func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    self.collectionView.performBatchUpdates({
      self.blocks.forEach { (block) in
        block()
      }
    }, completion: nil)
  }
}
