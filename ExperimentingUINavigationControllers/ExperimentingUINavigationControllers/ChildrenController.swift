//
//  ChildrenController.swift
//  ExperimentingUINavigationControllers
//
//  Created by 那須毅康 on 2020/12/15.
//

import UIKit

class ChildrenController: UIViewController {
  
  lazy var homeButton: UIBarButtonItem = {
    let button = UIBarButtonItem(title: "home", style: .plain, target: self, action: #selector(didTapButton))
    return button
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationItem.rightBarButtonItem = self.homeButton
  }

  @IBAction func unwindToMe(segue: UIStoryboardSegue){}

  @objc func didTapButton(_ sender: UIBarButtonItem) {
    self.navigationController?.popToRootViewController(animated: true)
  }
}
