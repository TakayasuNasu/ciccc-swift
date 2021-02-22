//
//  ToDoEditViewController.swift
//  SimpleToDoWithCoreData
//
//  Created by Takayasu Nasu on 2021/02/20.
//

import UIKit
import SnapKit
import Combine
import CombineCocoa

class ToDoMutationViewController: UIViewController {

  lazy var saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(addOrUpdate))

  let viewModel = ToDoMutationViewModel()

  var subscriptions = Set<AnyCancellable>()

  let textField: UITextField = {
    let textField = UITextField()
    textField.borderStyle = .roundedRect
    return textField
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    super.title = Titles.EDIT
    super.view.backgroundColor = .systemBackground
    super.navigationItem.rightBarButtonItem = self.saveButton

    self.setUI()

    self.textField.textPublisher
      .compactMap { $0 }
      .sink { text in
        self.viewModel.todoTitle = text
      }
      .store(in: &subscriptions)
  }

}

extension ToDoMutationViewController {

  private func setUI() {
    super.view.addSubview(self.textField)
    self.textField.snp.makeConstraints { (make) -> Void in
      make.top.equalTo(super.view.safeAreaLayoutGuide).offset(20)
      make.leading.equalTo(super.view.safeAreaLayoutGuide).offset(20)
      make.trailing.equalTo(super.view.safeAreaLayoutGuide).offset(20)
      make.height.equalTo(40)
    }
  }
  
  @objc private func addOrUpdate() {
    self.viewModel.save()
    super.navigationController?.popToRootViewController(animated: true)
  }
}
