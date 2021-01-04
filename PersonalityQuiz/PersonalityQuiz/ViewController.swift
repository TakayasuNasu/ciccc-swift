//
//  ViewController.swift
//  PersonalityQuiz
//
//  Created by 那須毅康 on 2020/12/15.
//

import UIKit

class ViewController: UIViewController {

  let mainStackView: UIStackView = {
    let main = UIStackView()
    main.translatesAutoresizingMaskIntoConstraints = false
    main.axis = .vertical
    main.alignment = .center
    main.distribution = .equalSpacing
    return main
  }()

  let mainTitle: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Which Animal Are You?"
    label.font = UIFont(name: "Georgia", size: 30.0)
    return label
  }()

  let beginButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Begin Personality Quiz", for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.addTarget(self, action: #selector(goNext(_:)), for: .touchUpInside)
    return button
  }()

  let emojiDog: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "🐶"
    label.font = .systemFont(ofSize: 40.0)
    return label
  }()

  let emojiCat: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "🐱"
    label.font = .systemFont(ofSize: 40.0)
    return label
  }()

  let emojiRabbit: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "🐰"
    label.font = .systemFont(ofSize: 40.0)
    return label
  }()

  let emojiTurtle: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "🐢"
    label.font = .systemFont(ofSize: 40.0)
    return label
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
    self.view.addSubview(self.mainStackView)
    self.view.addSubview(emojiDog)
    self.view.addSubview(emojiCat)
    self.view.addSubview(emojiRabbit)
    self.view.addSubview(emojiTurtle)
    self.setupView()
  }

  private func setupView() {
    self.mainStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    self.mainStackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    self.mainStackView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
    self.mainStackView.heightAnchor.constraint(equalToConstant: 80.0).isActive = true
    self.mainStackView.addArrangedSubview(mainTitle)
    self.mainStackView.addArrangedSubview(beginButton)

    self.emojiDog.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
    self.emojiDog.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
    self.emojiCat.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
    self.emojiCat.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
    self.emojiRabbit.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    self.emojiRabbit.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
    self.emojiTurtle.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    self.emojiTurtle.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
  }

  @objc private func goNext(_ sender: UIButton) {
    present(MyNavigationController(), animated: true, completion: nil)
  }

}

