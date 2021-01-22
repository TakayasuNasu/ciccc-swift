//
//  MenuItemDetailViewController.swift
//  Restaurant
//
//  Created by Takayasu Nasu on 2021/01/21.
//

import UIKit

class MenuItemDetailViewController: UIViewController {

  let menuItem: MenuItem

  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var priceLabel: UILabel!
  @IBOutlet weak var detailTextLabel: UILabel!
  @IBOutlet weak var addToOrderButton: UIButton!

  init?(coder: NSCoder, menuItem: MenuItem) {
    self.menuItem = menuItem
    super.init(coder: coder)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    self.addToOrderButton.layer.cornerRadius = 5.0
    self.updateUI()
  }

  func updateUI() {
    nameLabel.text = self.menuItem.name
    priceLabel.text = MenuItem.priceFormatter.string(from: NSNumber(value: self.menuItem.price))
    detailTextLabel.text = self.menuItem.detailText
  }


  @IBAction func orderButtonTapped(_ sender: UIButton) {
    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.1, options: [], animations: {
      self.addToOrderButton.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
      self.addToOrderButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
    }, completion: nil)
    MenuController.shared.order.menuItems.append(self.menuItem)
  }
}
