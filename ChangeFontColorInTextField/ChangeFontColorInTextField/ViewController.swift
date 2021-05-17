//
//  ViewController.swift
//  ChangeFontColorInTextField
//
//  Created by Takayasu Nasu on 2021/05/17.
//

import UIKit

class ViewController: UIViewController {

  let textField: UITextField = {
    let textFeild = UITextField()
    textFeild.backgroundColor = .white
    textFeild.translatesAutoresizingMaskIntoConstraints = false
    return textFeild
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    super.view.backgroundColor = .systemGray2
    super.view.addSubview(self.textField)

    self.textField.delegate = self

    self.textField.centerXAnchor.constraint(
      equalTo: super.view.centerXAnchor
    ).isActive = true
    self.textField.centerYAnchor.constraint(
      equalTo: super.view.centerYAnchor
    ).isActive = true
    self.textField.widthAnchor.constraint(
      equalTo: super.view.widthAnchor,
      multiplier: 0.7
    ).isActive = true
    self.textField.heightAnchor.constraint(
      equalTo: super.view.heightAnchor,
      multiplier: 0.05
    ).isActive = true
  }


}

extension ViewController: UITextFieldDelegate {

  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    if let text = textField.text {
      if let range = text.lowercased().range(of: "red") {
        let attribute = NSMutableAttributedString(string: text)
        attribute.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(range, in: text))
        textField.attributedText = attribute
      }
      return true
    }
    return false
  }
}
