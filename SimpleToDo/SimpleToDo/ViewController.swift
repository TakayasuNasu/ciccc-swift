//
//  ViewController.swift
//  SimpleToDo
//
//  Created by 那須毅康 on 2021/01/09.
//

import UIKit

class ViewController: UIViewController {

  let cellId = "ToDoCell"
  private let dataSource = ToDoDataSource()

  let tableView: UITableView = {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    return tableView
  }()

  lazy var addOrUpdateButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addToDo))
  lazy var removeButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(removeToDo))

  var todoList: ToDoList = defaultData {
    didSet {
      self.dataSource.setUpModel(self.todoList)
      self.tableView.reloadData()
    }
  }

  var selectedIndexes: [IndexPath] = []
  var selectedIndex: IndexPath?

  override func viewDidLoad() {
    super.viewDidLoad()
    super.view.backgroundColor = .white
    super.title = "ToDo Items"
    super.navigationItem.leftBarButtonItem = editButtonItem
    super.navigationItem.rightBarButtonItems = [self.addOrUpdateButton, self.removeButton]
    self.settingTable()
    self.setupTableView()
  }

  private func settingTable() {
    self.tableView.dataSource = self.dataSource
    self.tableView.delegate = self
    self.tableView.register(ToDoTableViewCell.self, forCellReuseIdentifier: cellId)
    self.tableView.allowsMultipleSelectionDuringEditing = true
    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: { [weak self] in
      self?.todoList = defaultData
    })

  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    super.navigationController?.navigationBar.prefersLargeTitles = true
    self.animate()
  }

  private func setupTableView() {
    super.view.addSubview(self.tableView)
    self.tableView.topAnchor.constraint(equalTo: super.view.topAnchor).isActive = true
    self.tableView.leftAnchor.constraint(equalTo: super.view.leftAnchor).isActive = true
    self.tableView.bottomAnchor.constraint(equalTo: super.view.bottomAnchor).isActive = true
    self.tableView.rightAnchor.constraint(equalTo: super.view.rightAnchor).isActive = true
  }

  @objc func animate() {
    UIView.animate(withDuration: 4, animations: {
      self.tableView.alpha = 0.0
    }) {(_ Bool) in
      self.showAgain()
    }
  }

  func showAgain() {
    UIView.animate(withDuration: 2, animations: {
      self.tableView.alpha = 1.0
    }) {(_ Bool) in
      self.animate()
    }
  }

  @objc func addToDo() {
    let nextViewController = ToDoMutationViewController()
    nextViewController.delegate = self
    super.navigationController?.pushViewController(nextViewController , animated: true)
  }

  @objc func removeToDo() {
    if let indexes = self.tableView.indexPathsForSelectedRows {
      for indexPath in indexes {
        self.todoList.remove(at: indexPath)
      }
    }
  }
  

}


extension ViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if self.tableView.isEditing {
    } else {
      var todo: ToDo = self.todoList.remove(at: indexPath)
      todo.isCompleted = !todo.isCompleted
      self.todoList.insert(at: indexPath, with: todo)
    }
  }

  func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    if self.tableView.isEditing {
      self.selectedIndexes.removeAll(where: { $0.section == indexPath.section && $0.row == indexPath.row})
    }
  }

  override func setEditing(_ editing: Bool, animated: Bool) {
    super.setEditing(editing, animated: animated)
    self.tableView.isEditing = editing
  }

  func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
    self.selectedIndex = indexPath
    let nextViewController = ToDoMutationViewController()
    nextViewController.todo = self.todoList.find(by: indexPath)
    nextViewController.delegate = self
    super.navigationController?.pushViewController(nextViewController , animated: true)
  }

}

extension ViewController: ToDoMutationDelegate {
  func add(_ todo: ToDo) {
    guard !todo.title.isEmpty else { return }
    self.todoList.mediumPriorities.append(todo)
    self.tableView.reloadData()
  }

  func edit(_ todo: ToDo) {
    if let indexPath = self.selectedIndex {
      self.todoList.remove(at: indexPath)
      self.todoList.insert(at: indexPath, with: todo)
    }
  }

}
