//
//  ViewController.swift
//  GuidedProject
//
//  Created by 那須毅康 on 2020/12/04.
//

import UIKit

class ViewController: UIViewController {

  var lightOn = true

  @IBOutlet var lightButton: UIButton!

  override func viewDidLoad() {
    super.viewDidLoad()
    self.updateUI()
  }

  fileprivate func updateUI() {
    self.view.backgroundColor = self.lightOn ? .white : .black
  }


  @IBAction func buttonPressed(_ sender: Any) {
    self.lightOn.toggle()
    self.updateUI()
  }
}

