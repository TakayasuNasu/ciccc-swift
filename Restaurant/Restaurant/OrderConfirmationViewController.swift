//
//  OrderConfirmationViewController.swift
//  Restaurant
//
//  Created by Takayasu Nasu on 2021/01/22.
//

import UIKit

class OrderConfirmationViewController: UIViewController {

  let minutesTopPrepare: Int
  @IBOutlet weak var confirmationLabel: UILabel!
  
  init?(coder: NSCoder, minutesTopPrepare: Int) {
    self.minutesTopPrepare = minutesTopPrepare
    super.init(coder: coder)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

  }

  @IBAction func unwindToOrderList(_ sender: UIStoryboard) {
  }
}
