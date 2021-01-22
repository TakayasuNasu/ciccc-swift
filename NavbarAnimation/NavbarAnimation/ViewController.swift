//
//  ViewController.swift
//  NavbarAnimation
//
//  Created by 那須毅康 on 2021/01/13.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

  let url = URL(string: "https://swapi.dev/api/people/3")!
  var heightConstraint: Constraint? = nil
  var isOpend: Bool = false

  let navigationUIView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
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
    main.translatesAutoresizingMaskIntoConstraints = false
    main.axis = .horizontal
    main.alignment = .center
    main.distribution = .fillEqually
    return main
  }()

  let imageViews: [UIImageView] = {
    let imageViews = [
      UIImageView(image: UIImage(named: "oreos")),
      UIImageView(image: UIImage(named: "pizza_pockets")),
      UIImageView(image: UIImage(named: "pop_tarts")),
      UIImageView(image: UIImage(named: "popsicle")),
      UIImageView(image: UIImage(named: "ramen"))]
    for img in imageViews {
      img.translatesAutoresizingMaskIntoConstraints = false
      img.contentMode = UIView.ContentMode.scaleAspectFit
      img.isUserInteractionEnabled = true
    }
    return imageViews
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    super.view.backgroundColor = .white
    self.setupOriginalNavigationUI()
    self.setupStackView()
    self.setupImageview()
  }

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

  func setupImageview() {
    for img in self.imageViews {
      self.navigationStackView.addArrangedSubview(img)
      img.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(setNameOnTable(_:))))
    }
  }

  @objc func growNavigationBar(_ sender: UIButton) {
    let offsetValue: Int = self.isOpend ? 0 : 280
    let rotateTransform = self.isOpend ? CGAffineTransform.identity : CGAffineTransform(rotationAngle: .pi / 4)
    UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.3, animations: {
      self.heightConstraint?.update(offset: offsetValue)
      sender.transform = rotateTransform
      self.view.layoutIfNeeded()
    }, completion: { (_) in
      self.isOpend = !self.isOpend
    })
  }

  @objc func setNameOnTable(_ sender: UITapGestureRecognizer) {
    print(12)
  }

}

