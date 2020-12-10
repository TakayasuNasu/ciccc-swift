//
//  ViewController.swift
//  ApplePie
//
//  Created by 那須毅康 on 2020/12/08.
//

import UIKit

class ViewController: UIViewController {

  var listOfWords = ["buccaneer", "swift", "glorious", "incandescent", "bug", "program"]
  var currentGame: Game!
  let incorrectMovesAllowed = 7
  var totalWins = 0 {
    didSet {
      self.newRound()
    }
  }
  var totalLosses = 0 {
    didSet {
      self.newRound()
    }
  }

  let mainStackView: UIStackView = {
    let main = UIStackView()
    main.translatesAutoresizingMaskIntoConstraints = false
    main.axis = .vertical
    return main
  }()

  let tree: UIImageView = {
    let imageName: String = "Tree 0"
    let img = UIImageView(image: UIImage(named: imageName))
    img.translatesAutoresizingMaskIntoConstraints = false
    img.contentMode = UIView.ContentMode.scaleAspectFit
    return img
  }()

  let buttonAreaStack: UIStackView = {
    let stack = UIStackView()
    stack.translatesAutoresizingMaskIntoConstraints = false
    stack.axis = .vertical
    stack.alignment = .center
    stack.distribution = .fillEqually
    stack.spacing = 5
    return stack
  }()

  let stackViews: [UIStackView] = {
    let views = [UIStackView(), UIStackView(), UIStackView()]
    for v in views {
      v.translatesAutoresizingMaskIntoConstraints = false
      v.axis = .horizontal
      v.alignment = .fill
      v.distribution = .fill
      v.spacing = 5
    }
    return views
  }()

  let buttons: [UIButton] = {
    let buttons = (1...26).map{_ in UIButton(type: UIButton.ButtonType.system)}
    for button in buttons {
      button.translatesAutoresizingMaskIntoConstraints = false
      button.setTitle("Q", for: .normal)
      button.titleLabel?.font = UIFont.systemFont(ofSize: 30.0)
      button.addTarget(self, action: #selector(onTapLetter), for: .touchUpInside)
    }
    return buttons
  }()

  let correctWord: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "label"
    label.font = UIFont.systemFont(ofSize: 30.0)
    return label
  }()

  let score: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "label"
    label.font = UIFont.systemFont(ofSize: 20.0)
    return label
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.addSubview(mainStackView)
    self.setupTreeImageView()
    self.setupImageView()
    self.setupButtonArea()
    self.setupLabel()
    self.newRound()
  }

  fileprivate func setupTreeImageView() {
    self.mainStackView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
    self.mainStackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    self.mainStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
    self.mainStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
  }

  fileprivate func setupImageView() {
    self.mainStackView.addArrangedSubview(self.tree)
  }

  fileprivate func setupButtonArea() {
    // mainStack => tree, buttonAreaStack. buttonAreaStack => stackViews × 3, stackViews => above middle below
    self.mainStackView.addArrangedSubview(buttonAreaStack)
    for stackView in self.stackViews {
      self.buttonAreaStack.addArrangedSubview(stackView)
    }
    ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P",
     "A", "S", "D", "F", "G", "H", "J", "K", "L",
     "Z", "X", "C", "V", "B", "N", "M"].enumerated()
      .forEach{(i,c) in self.buttons[i].setTitle(c, for: .normal)}
    for buttonView in self.buttons[...9] {
      self.stackViews[0].addArrangedSubview(buttonView)
      buttonView.aspectRation(1.0/1.0).isActive = true
    }
    for buttonView in self.buttons[10...18] {
      self.stackViews[1].addArrangedSubview(buttonView)
      buttonView.aspectRation(1.0/1.0).isActive = true
    }
    for buttonView in self.buttons[19...] {
      self.stackViews[2].addArrangedSubview(buttonView)
      buttonView.aspectRation(1.0/1.0).isActive = true
    }
  }

  fileprivate func setupLabel() {
    self.buttonAreaStack.addArrangedSubview(self.correctWord)
    self.buttonAreaStack.addArrangedSubview(self.score)
  }

  private func newRound() {
    if !self.listOfWords.isEmpty {
      self.currentGame = Game(
        word: self.listOfWords.removeFirst(),
        incorrectMovesRemaining: self.incorrectMovesAllowed,
        guessedLetters: [])
      self.enableLetterButtons(true)
      self.updateUI()
    } else {
      self.enableLetterButtons(false)
    }
  }

  private func updateUI() {
    self.correctWord.text = self.currentGame.formattedWord.map({ String($0) }).joined(separator: " ")
    self.score.text = "Wins: \(self.totalWins), Losses: \(self.totalLosses)"
    self.tree.image = UIImage(named: "Tree \(self.currentGame.incorrectMovesRemaining)")
  }

  private func updateGameState() {
    if self.currentGame.incorrectMovesRemaining == 0 {
      self.totalLosses += 1
    } else if self.currentGame.word == self.currentGame.formattedWord {
      self.totalWins += 1
    } else {
      self.updateUI()
    }
  }

  private func enableLetterButtons(_ enable: Bool) {
    self.buttons.forEach{ button in button.isEnabled = enable }
  }

  @objc private func onTapLetter(_ sender: UIButton) {
    sender.isEnabled = false
    let letter = sender.title(for: .normal) ?? "Q"
    self.currentGame.playerGuessed(letter: Character(letter.lowercased()))
    self.updateGameState()
  }

}

extension UIView {
  func aspectRation(_ ratio: CGFloat) -> NSLayoutConstraint {
    return NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: self, attribute: .width, multiplier: ratio, constant: 0)
  }
}
