//
//  AnswerViewController.swift
//  PersonalityQuiz
//
//  Created by 那須毅康 on 2020/12/15.
//

import UIKit

class ResultsViewController: UIViewController {

  let doneButton: UIBarButtonItem = {
    let button = UIBarButtonItem()
    button.title = "Done"
    return button
  }()

  let mainStackView: UIStackView = {
    let main = UIStackView()
    main.translatesAutoresizingMaskIntoConstraints = false
    main.axis = .vertical
    main.alignment = .center
    main.distribution = .equalSpacing
    return main
  }()

  let result: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Label"
    label.font = .systemFont(ofSize: 50.0)
    return label
  }()

  let desc: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Label"
    label.font = .systemFont(ofSize: 16.0)
    return label
  }()

  var responses: [Answer]

  init(responses: [Answer]) {
    self.responses = responses
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Results"
    self.view.backgroundColor = .white
    self.navigationItem.rightBarButtonItem = self.doneButton
    self.view.addSubview(self.mainStackView)
    self.setupview()
    self.calculatePersonalityResult()
  }

  private func setupview() {
    self.mainStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0).isActive = true
    self.mainStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
    self.mainStackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    self.mainStackView.heightAnchor.constraint(equalToConstant: 100.0).isActive = true
    self.mainStackView.addArrangedSubview(self.result)
    self.mainStackView.addArrangedSubview(self.desc)
  }

  private func calculatePersonalityResult() {
    let frequencyOfAnswers = self.responses.reduce(into: [AnimalType: Int]()) {(counts, answer) in
      if let existingCount = counts[answer.type] {
        counts[answer.type] = existingCount + 1
      } else {
        counts[answer.type] = 1
      }
    }
    let mostCommonAnswer = frequencyOfAnswers.sorted { $0.1 > $1.1 }.first!.key
    self.result.text = "You are a \(mostCommonAnswer.rawValue)!"
    self.desc.text = mostCommonAnswer.definition
  }

}
