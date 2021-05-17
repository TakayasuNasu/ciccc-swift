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
      var rangeList: [NSRange] = []
      self.redToOther(text, &rangeList)
      let attribute = NSMutableAttributedString(string: text)
      for nsRange in rangeList {
        attribute.addAttribute(.foregroundColor, value: UIColor.red, range:nsRange)
      }
      textField.attributedText = attribute
      return true
    }
    return false
  }

  func redToOther(_ text: String, _ rangeList: inout [NSRange]) {
    if !text.contains("red") {
      return
    }
    let range = text.range(of: "red")!
    rangeList.append(NSRange(range, in: text))
    var word = text
    word.replaceSubrange(range, with: "000")
    self.redToOther(word, &rangeList)
  }
}
