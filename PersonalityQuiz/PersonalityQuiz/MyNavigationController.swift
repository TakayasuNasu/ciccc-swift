//
//  MyNavigationController.swift
//  PersonalityQuiz
//
//  Created by 那須毅康 on 2020/12/15.
//

import UIKit

class MyNavigationController: UINavigationController {

  override func viewDidLoad() {
    super.viewDidLoad()
    self.viewControllers = [QuestionViewController()]
  }
}
