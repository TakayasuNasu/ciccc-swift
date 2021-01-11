//
//  ToDoMutationViewController.swift
//  SimpleToDo
//
//  Created by 那須毅康 on 2021/01/09.
//

import UIKit

class ToDoMutationViewController: UIViewController {

  var todo: ToDo?
  weak var delegate: ToDoMutationDelegate?
  lazy var saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(addOrUpdate))

  let textField: UITextField = {
    let textField = UITextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.borderStyle = .roundedRect
    return textField
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    super.view.backgroundColor = .white
    if self.todo == nil {
      super.title = "Add ToDo Item"
    } else {
      super.title = "Edit ToDo Item"
      self.textField.text = self.todo?.title
    }
    super.navigationItem.rightBarButtonItem = self.saveButton
    self.setupView()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    super.navigationController?.navigationBar.prefersLargeTitles = false
  }

  private func setupView() {
    super.view.addSubview(self.textField)
    self.textField.topAnchor.constraint(equalTo: super.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
    self.textField.constraintHeight(equalToConstant: 50)
    self.textField.leadingAnchor.constraint(equalTo: super.view.leadingAnchor, constant: 20).isActive = true
    self.textField.trailingAnchor.constraint(equalTo: super.view.trailingAnchor, constant: -20).isActive = true
  }

  @objc private func addOrUpdate() {
    let data = ToDo(title: self.textField.text!, priority: 1, isCompleted: false)
    if self.todo == nil {
      self.delegate?.add(data)
    } else {
      self.delegate?.edit(data)
    }
    super.navigationController?.popToRootViewController(animated: true)
  }
  
}
