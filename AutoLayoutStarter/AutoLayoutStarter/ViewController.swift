//
//  ViewController.swift
//  AutoLayoutStarter
//
//  Created by Derrick Park on 2019-04-17.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  let mainView: UIView = {
    let main = UIView()
    // important when setting contraints programmatically
    main.translatesAutoresizingMaskIntoConstraints = false
    main.backgroundColor = .green
    return main
  }()

  let purpleBox: UIView = {
    let box = UIView()
    box.translatesAutoresizingMaskIntoConstraints = false
    box.backgroundColor = .purple
    return box
  }()

  let centerStackView: UIStackView = {
    let stack = UIStackView()
    stack.translatesAutoresizingMaskIntoConstraints = false
    stack.axis = .vertical
    stack.alignment = .center
    stack.distribution = .equalCentering
    stack.translatesAutoresizingMaskIntoConstraints = false
    return stack
  }()

  let blueBoxes: [UIView] = {
    let boxes = [UIView(), UIView(), UIView()]
    for box in boxes {
      box.translatesAutoresizingMaskIntoConstraints = false
      box.backgroundColor = .blue
    }
    return boxes
  }()

  let redBox: UIView = {
    let box = UIView()
    box.translatesAutoresizingMaskIntoConstraints = false
    box.backgroundColor = .red
    return box
  }()

  let orangeLeftBox: UIView = {
    let box = UIView()
    box.translatesAutoresizingMaskIntoConstraints = false
    box.backgroundColor = .orange
    return box
  }()

  let orangeRighttBox: UIView = {
    let box = UIView()
    box.translatesAutoresizingMaskIntoConstraints = false
    box.backgroundColor = .orange
    return box
  }()

  let squareButton: UIButton = {
    let butt = UIButton(type: .system)
    butt.setTitle("Square", for: .normal)
    butt.translatesAutoresizingMaskIntoConstraints = false
    butt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
    butt.addTarget(self, action: #selector(squareTapped), for: .touchUpInside)
    return butt
  }()
  
  let portraitButton: UIButton = {
    let butt = UIButton(type: .system)
    butt.setTitle("Portrait", for: .normal)
    butt.translatesAutoresizingMaskIntoConstraints = false
    butt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
    butt.addTarget(self, action: #selector(portraitTapped), for: .touchUpInside)
    return butt
  }()
  
  let landScapeButton: UIButton = {
    let butt = UIButton(type: .system)
    butt.setTitle("Landscape", for: .normal)
    butt.translatesAutoresizingMaskIntoConstraints = false
    butt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
    butt.addTarget(self, action: #selector(landscapeTapped), for: .touchUpInside)
    return butt
  }()
  
  var widthAnchor: NSLayoutConstraint?
  var heightAnchor: NSLayoutConstraint?

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    view.addSubview(mainView)
    self.mainView.addSubview(redBox)
    self.redBox.addSubview(orangeLeftBox)
    self.redBox.addSubview(orangeRighttBox)
    self.mainView.addSubview(purpleBox)
    self.mainView.addSubview(centerStackView)
    setupLayout()
    self.setupRedBox()
    self.setupPurpleBox()
    self.setupCenterBox()
  }

  fileprivate func setupLayout() {
    mainView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    mainView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    widthAnchor = mainView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7, constant: 0)
    widthAnchor?.isActive = true
    
    heightAnchor = mainView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.7, constant: 0)
    heightAnchor?.isActive = true
    
    let buttStackView = UIStackView(arrangedSubviews: [
      squareButton, portraitButton, landScapeButton])
    buttStackView.translatesAutoresizingMaskIntoConstraints = false
    buttStackView.axis = .horizontal
    buttStackView.alignment = .center
    buttStackView.distribution = .fillEqually
    
    view.addSubview(buttStackView)
    NSLayoutConstraint.activate([
      buttStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
      buttStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      buttStackView.heightAnchor.constraint(equalToConstant: 50),
      buttStackView.widthAnchor.constraint(equalTo: view.widthAnchor)
      ])
  }

  fileprivate func setupRedBox() {
    self.redBox.topAnchor.constraint(equalTo: self.mainView.topAnchor, constant: 10).isActive = true
    self.redBox.trailingAnchor.constraint(equalTo: self.mainView.trailingAnchor, constant: -20).isActive = true
    self.redBox.widthAnchor.constraint(equalToConstant: 300).isActive = true
    self.redBox.heightAnchor.constraint(equalToConstant: 50).isActive = true

    self.orangeLeftBox.leadingAnchor.constraint(equalTo: self.redBox.leadingAnchor, constant: 10).isActive = true
    self.orangeLeftBox.centerYAnchor.constraint(equalTo: self.redBox.centerYAnchor).isActive = true
    self.orangeLeftBox.widthAnchor.constraint(equalToConstant: 160).isActive = true
    self.orangeLeftBox.heightAnchor.constraint(equalTo: self.redBox.heightAnchor, multiplier: 0.6).isActive = true

    self.orangeRighttBox.trailingAnchor.constraint(equalTo: self.redBox.trailingAnchor, constant: -10).isActive = true
    self.orangeRighttBox.centerYAnchor.constraint(equalTo: self.redBox.centerYAnchor).isActive = true
    self.orangeRighttBox.widthAnchor.constraint(equalToConstant: 80).isActive = true
    self.orangeRighttBox.heightAnchor.constraint(equalTo: self.redBox.heightAnchor, multiplier: 0.6).isActive = true
  }

  fileprivate func setupPurpleBox() {
    self.purpleBox.trailingAnchor.constraint(equalTo: self.mainView.trailingAnchor, constant: -20).isActive = true
    self.purpleBox.bottomAnchor.constraint(equalTo: self.mainView.bottomAnchor, constant: -10).isActive = true
    self.purpleBox.widthAnchor.constraint(equalTo: self.mainView.widthAnchor, multiplier: 0.6, constant: 0).isActive = true
    self.purpleBox.heightAnchor.constraint(equalToConstant: 50).isActive = true
  }

  fileprivate func setupCenterBox() {
    self.centerStackView.centerXAnchor.constraint(equalTo: self.mainView.centerXAnchor).isActive = true
    self.centerStackView.centerYAnchor.constraint(equalTo: self.mainView.centerYAnchor).isActive = true
    self.centerStackView.widthAnchor.constraint(equalToConstant: 50).isActive = true
    self.centerStackView.heightAnchor.constraint(equalTo: self.mainView.heightAnchor, multiplier: 0.8).isActive = true

    for box in blueBoxes {
      self.centerStackView.addArrangedSubview(box)
      box.widthAnchor.constraint(equalTo: self.centerStackView.widthAnchor).isActive = true
      box.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
  }

  @objc private func squareTapped() {
    view.layoutIfNeeded()
    UIView.animate(withDuration: 2.0) {
      self.widthAnchor?.isActive = false
      self.widthAnchor? = self.mainView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9)
      self.widthAnchor?.isActive = true
      
      self.heightAnchor?.isActive = false
      self.heightAnchor? = self.mainView.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9)
      self.heightAnchor?.isActive = true
      self.view.layoutIfNeeded()
    }
  }
  
  @objc private func portraitTapped() {
    view.layoutIfNeeded()
    UIView.animate(withDuration: 2.0) {
      self.widthAnchor?.isActive = false
      self.widthAnchor? = self.mainView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.7)
      self.widthAnchor?.isActive = true
      
      self.heightAnchor?.isActive = false
      self.heightAnchor? = self.mainView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.7)
      self.heightAnchor?.isActive = true
      self.view.layoutIfNeeded()
    }
  }
  
  @objc private func landscapeTapped() {
    view.layoutIfNeeded()
    UIView.animate(withDuration: 2.0) {
      self.widthAnchor?.isActive = false
      self.widthAnchor? = self.mainView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.95)
      self.widthAnchor?.isActive = true
      
      self.heightAnchor?.isActive = false
      self.heightAnchor? = self.mainView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.4)
      self.heightAnchor?.isActive = true
      self.view.layoutIfNeeded()
    }
  }
}

