//
//  ViewController.swift
//  NavbarAnimation
//
//  Created by 那須毅康 on 2021/01/13.
//

import UIKit
import SnapKit

let cellId = "cell"

class ViewController: UIViewController {

  let viewModel: ViewModel = ViewModel()
  let url = URL(string: "https://swapi.dev/api/people/3")!
  var heightConstraint: Constraint? = nil

  let tableView: UITableView = UITableView()

  let navigationUIView: UIView = {
    let view = UIView()
    view.backgroundColor = .gray
    return view
  }()

  let addButton: UIButton = {
    let button = UIButton()
    button.setTitle("＋", for: .normal)
    button.setTitleColor(.blue, for: .normal)
    return button
  }()

  let navigationStackView: UIStackView = {
    let main = UIStackView()
    main.axis = .horizontal
    main.alignment = .center
    main.distribution = .fillEqually
    return main
  }()

  lazy var imageViews: [UIImageView] = {
    let imageViews: [UIImageView] = self.viewModel.sweets.map { sweet in
      let img = UIImageView(image: UIImage(named: sweet.name))
      img.contentMode = UIView.ContentMode.scaleAspectFit
      img.isUserInteractionEnabled = true
      img.accessibilityValue = sweet.name
      return img
    }
    return imageViews
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    super.view.backgroundColor = .white
    self.setupOriginalNavigationUI()
    self.setupStackView()
    self.setupImageview()
    self.setTableViewIntoSuperView()
  }

}

extension ViewController {

  private func setupOriginalNavigationUI() {
    self.addButton.addTarget(self, action: #selector(growNavigationBar(_ :)), for: .touchUpInside)
    super.navigationItem.setRightBarButton(UIBarButtonItem(customView: addButton), animated: true)
    super.view.addSubview(self.navigationUIView)
    super.navigationController?.navigationBar.barTintColor = .gray
    self.navigationUIView.snp.makeConstraints { (make) -> Void in
      make.top.equalTo(super.view.safeAreaInsets)
      self.heightConstraint =  make.height.equalTo(44).constraint
      make.leading.equalTo(super.view)
      make.trailing.equalTo(super.view)
    }
  }

  private func setupStackView() {
    self.navigationUIView.addSubview(self.navigationStackView)
    self.navigationStackView.snp.makeConstraints { (make) -> Void in
      make.bottom.equalTo(self.navigationUIView)
      make.height.equalTo(self.navigationUIView).multipliedBy(0.5)
      make.leading.equalTo(super.view)
      make.trailing.equalTo(super.view)
    }
  }

  private func setupImageview() {
    for img in self.imageViews {
      self.navigationStackView.addArrangedSubview(img)
      img.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(setNameOnTable(_:))))
    }
  }

  private func setTableViewIntoSuperView() {
    super.view.addSubview(self.tableView)
    self.tableView.snp.makeConstraints { make -> Void in
      make.top.equalTo(self.navigationUIView.snp.bottom)
      make.bottom.equalTo(super.view.snp.bottom)
      make.leading.trailing.equalToSuperview()
    }
    self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    self.tableView.delegate = self
    self.tableView.dataSource = self
  }

  @objc func growNavigationBar(_ sender: UIButton) {
    self.viewModel.toggleOffset()
    let rotateTransform = self.viewModel.isOpened ? CGAffineTransform.identity : CGAffineTransform(rotationAngle: .pi / 4)
    UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.3, animations: {
      self.heightConstraint?.update(offset: self.viewModel.offset)
      sender.transform = rotateTransform
      self.view.layoutIfNeeded()
    }, completion: { (_) in
      self.viewModel.toggleOpened()
    })
  }

  @objc func setNameOnTable(_ sender: UITapGestureRecognizer) {
    let imageView = sender.view as! UIImageView
    let imageName = imageView.accessibilityValue ?? "sweet"
    self.viewModel.imageNamesDataSource.append(imageName)
    self.tableView.reloadData()
  }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.viewModel.imageNamesDataSource.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
    cell.textLabel?.text = self.viewModel.imageNamesDataSource[indexPath.item]
    return cell
  }


}
