//
//  OrderTableViewController.swift
//  Restaurant
//
//  Created by Takayasu Nasu on 2021/01/21.
//

import UIKit

class OrderTableViewController: UITableViewController {

  var minutesToPrepareOrder = 0

  override func viewDidLoad() {
    super.viewDidLoad()
    NotificationCenter.default.addObserver(super.tableView!, selector: #selector(UITableView.reloadData), name: MenuController.orderUpdatedNotification, object: nil)
  }

  @IBSegueAction func confirmOrder(_ coder: NSCoder) -> OrderConfirmationViewController? {
    return OrderConfirmationViewController(coder: coder, minutesTopPrepare: self.minutesToPrepareOrder)
  }
  
  @IBAction func submitTapped(_ sender: Any) {
    let orderTotal = MenuController.shared.order.menuItems.reduce(0.0)
    { (result, menuItem) -> Double in
      return result + menuItem.price
    }

    let formattedTotal = MenuItem.priceFormatter.string(from: NSNumber(value: orderTotal)) ?? "\(orderTotal)"

    let alertController = UIAlertController(title: "Confirm Order",
                                            message: "You are about to submit your order with a total of \(formattedTotal)",
                                            preferredStyle: .actionSheet)
    alertController.addAction(UIAlertAction(title: "Submit", style: .default, handler: { _ in
      self.uploadOrder()
    }))
    alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    present(alertController, animated: true, completion: nil)
  }

  @IBAction func unwindToOrderList(_ segue: UIStoryboardSegue) {
    if segue.identifier == "dismissConfirmation" {
      MenuController.shared.order.menuItems.removeAll()
    }
  }

  func uploadOrder() {
    let menuIds = MenuController.shared.order.menuItems.map { $0.id }
    MenuController.shared.submitOrder(forMenuIDs: menuIds)
    { (result) in
      switch result {
      case .success(let minutesToPrepare):
        DispatchQueue.main.async {
          self.minutesToPrepareOrder = minutesToPrepare
          self.performSegue(withIdentifier: "confirmOrder",
                            sender: nil)
        }
      case .failure(let error):
        self.displayError(error, title: "Order Submission Failed")
      }
    }
  }

  func displayError(_ error: Error, title: String) {
    DispatchQueue.main.async {
      let alert = UIAlertController(title: title, message:
                                      error.localizedDescription, preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "Dismiss",
                                    style: .default, handler: nil))
      self.present(alert, animated: true, completion: nil)
    }
  }


  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  func configure(_ cell: UITableViewCell, forItemAt indexPath: IndexPath) {
    let menuItem = MenuController.shared.order.menuItems[indexPath.row]
    cell.textLabel?.text = menuItem.name
    cell.detailTextLabel?.text = MenuItem.priceFormatter.string(from: NSNumber(value: menuItem.price))
    MenuController.shared.fetchImage(url: menuItem.imageURL) { (image) in
      guard let image = image else {return}
      DispatchQueue.main.async {
        if let currentIndexPath = self.tableView.indexPath(for: cell),
           currentIndexPath != indexPath {
          return
        }
        cell.imageView?.image = image
        cell.setNeedsLayout()
      }
    }
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return MenuController.shared.order.menuItems.count
  }

   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   let cell = tableView.dequeueReusableCell(withIdentifier: "Order", for: indexPath)
    self.configure(cell, forItemAt: indexPath)
   return cell
   }

   override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
   }

  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      MenuController.shared.order.menuItems.remove(at: indexPath.row)
    } else if editingStyle == .insert {
      // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
  }

  /*
   // Override to support rearranging the table view.
   override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

   }
   */

  /*
   // Override to support conditional rearranging of the table view.
   override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
   // Return false if you do not want the item to be re-orderable.
   return true
   }
   */

  /*
   // MARK: - Navigation

   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destination.
   // Pass the selected object to the new view controller.
   }
   */

}
