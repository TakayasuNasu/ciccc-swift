//
//  ViewController.swift
//  TipCalculator
//
//  Created by 那須毅康 on 2021/01/07.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var scrollView: UIScrollView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    registerForKeyboardNotification()
    let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(_:)))
    view.addGestureRecognizer(gestureRecognizer)

    scrollView.delegate = self
  }

  @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
    view.endEditing(true)
  }

  fileprivate func registerForKeyboardNotification() {
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
  }

  @objc func keyboardWasShown(_ notification: NSNotification) {
    guard let info = notification.userInfo, let keyboardFrameValue = info[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue else { return }
    let keyboardFrame = keyboardFrameValue.cgRectValue
    let keyboardHeight = keyboardFrame.size.height
    let insets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
    scrollView.contentInset = insets
    scrollView.scrollIndicatorInsets = insets
  }

  @objc func keyboardWillBeHidden(_ notification: NSNotification) {
    let insets = UIEdgeInsets.zero
    scrollView.contentInset = insets
    scrollView.scrollIndicatorInsets = insets
  }

}

extension ViewController: UIScrollViewDelegate {
  func viewForZooming(in scrollView: UIScrollView) -> UIView? {
    return nil
  }
}
