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

  var todoList: ToDoList = defaultData {
    didSet {
      self.dataSource.setUpModel(self.todoList)
      self.tableView.reloadData()
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    super.view.backgroundColor = .white
    super.title = "ToDo Items"
    super.navigationItem.leftBarButtonItem = editButtonItem
    super.navigationItem.rightBarButtonItem = self.addOrUpdateButton
    self.settingTable()
    self.setupTableView()
  }

  private func settingTable() {
    self.tableView.dataSource = self.dataSource
    self.tableView.delegate = self
    self.tableView.register(ToDoTableViewCell.self, forCellReuseIdentifier: cellId)
    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: { [weak self] in
      self?.todoList = defaultData
    })

  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    super.navigationController?.navigationBar.prefersLargeTitles = true
  }

  private func setupTableView() {
    super.view.addSubview(self.tableView)
    self.tableView.topAnchor.constraint(equalTo: super.view.topAnchor).isActive = true
    self.tableView.leftAnchor.constraint(equalTo: super.view.leftAnchor).isActive = true
    self.tableView.bottomAnchor.constraint(equalTo: super.view.bottomAnchor).isActive = true
    self.tableView.rightAnchor.constraint(equalTo: super.view.rightAnchor).isActive = true
  }

  @objc func addToDo() {
    let nextViewController = ToDoMutationViewController()
    nextViewController.delegate = self
    super.navigationController?.pushViewController(nextViewController , animated: true)
  }

}


extension ViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
    if let indexPath = self.tableView.indexPathForSelectedRow {
      switch indexPath.section {
      case 0:
        self.todoList.highPriorities.remove(at: indexPath.row)
        self.todoList.highPriorities.insert(todo, at: indexPath.row)
      case 1:
        self.todoList.mediumPriorities.remove(at: indexPath.row)
        self.todoList.mediumPriorities.insert(todo, at: indexPath.row)
      case 2:
        self.todoList.lowPriorities.remove(at: indexPath.row)
        self.todoList.lowPriorities.insert(todo, at: indexPath.row)
      default:
        self.todoList.highPriorities.remove(at: indexPath.row)
        self.todoList.highPriorities.insert(todo, at: indexPath.row)
      }
    }
  }

}
