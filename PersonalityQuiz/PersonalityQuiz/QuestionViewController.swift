//
//  QuestionViewController.swift
//  PersonalityQuiz
//
//  Created by 那須毅康 on 2020/12/15.
//

import UIKit

class QuestionViewController: UIViewController {

  let question: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Label"
    label.textAlignment = .center
    return label
  }()

  let wrapper: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.alignment = .center
    stackView.distribution = .equalSpacing
    return stackView
  }()

  let inner: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.alignment = .center
    stackView.distribution = .equalSpacing
    return stackView
  }()

  let rows: [UIStackView] = {
    let stackViews = [UIStackView(), UIStackView(), UIStackView(), UIStackView()]
    for stackView in stackViews {
      stackView.translatesAutoresizingMaskIntoConstraints = false
      stackView.axis = .horizontal
      stackView.alignment = .center
      stackView.distribution = .equalCentering
    }
    return stackViews
  }()

  let items: [(UILabel, UISwitch)] = {
    let items = [
      (UILabel(), UISwitch()),
      (UILabel(), UISwitch()),
      (UILabel(), UISwitch()),
      (UILabel(), UISwitch())
    ]
    for (label, switchButton) in items {
      label.translatesAutoresizingMaskIntoConstraints = false
      label.text = "Label"
      switchButton.isOn = false
    }
    return items
  }()

  let answerButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Submit Answer", for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.addTarget(self, action: #selector(goNext(_:)), for: .touchUpInside)
    return button
  }()

  var questions: [Question] = [
    Question(
      text: "Which food do you like the most?",
      type: .single,
      answers: [
        Answer(text: "Steak", type: .dog),
        Answer(text: "Fish", type: .cat),
        Answer(text: "Carrots", type: .rabbit),
        Answer(text: "Corn", type: .turtle)
      ]
    ),

    Question(
      text: "Which activities do you enjoy?",
      type: .multiple,
      answers: [
        Answer(text: "Swimming", type: .turtle),
        Answer(text: "Sleeping", type: .cat),
        Answer(text: "Cuddling", type: .rabbit),
        Answer(text: "Eating", type: .dog)
      ]
    ),

    Question(
      text: "How much do you enjoy car rides?",
      type: .ranged,
      answers: [
        Answer(text: "I dislike them", type: .cat),
        Answer(text: "I get a little nervous", type: .rabbit),
        Answer(text: "I barely notice them", type: .turtle),
        Answer(text: "I love them", type: .dog)
      ]
    )
  ]

  var questionIndex = 1

  var answersChosen: [Answer] = []

  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
    self.view.addSubview(self.question)
    self.view.addSubview(self.wrapper)
    self.setupView()
    self.updateUI()
  }

  private func setupView() {
    self.question.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
    self.question.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
    self.question.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
    self.question.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.2).isActive = true

    self.wrapper.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    self.wrapper.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
    self.wrapper.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
    self.wrapper.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.5).isActive = true
    self.wrapper.addArrangedSubview(self.inner)
    self.wrapper.addArrangedSubview(self.answerButton)

    self.inner.leadingAnchor.constraint(equalTo: self.wrapper.leadingAnchor).isActive = true
    self.inner.trailingAnchor.constraint(equalTo: self.wrapper.trailingAnchor).isActive = true

    for (i, stackview) in self.rows.enumerated() {
      self.inner.addArrangedSubview(stackview)
      stackview.leadingAnchor.constraint(equalTo: self.inner.leadingAnchor).isActive = true
      stackview.trailingAnchor.constraint(equalTo: self.inner.trailingAnchor).isActive = true
      stackview.heightAnchor.constraint(equalToConstant: 50).isActive = true
      stackview.addArrangedSubview(self.items[i].0)
      stackview.addArrangedSubview(self.items[i].1)
    }
  }

  private func updateUI() {
    navigationItem.title = "Question #\(self.questionIndex + 1)"
    let currentQuestion = self.questions[self.questionIndex]
    self.question.text = currentQuestion.text
    switch currentQuestion.type {
    case .single:
      updateMultipleStack(using: currentQuestion.answers)
    case .multiple:
      updateMultipleStack(using: currentQuestion.answers)
    case .ranged:
      updateMultipleStack(using: currentQuestion.answers)
    }
  }

  private func updateMultipleStack(using answers: [Answer]) {
    self.items[0].0.text = answers[0].text
    self.items[1].0.text = answers[1].text
    self.items[2].0.text = answers[2].text
    self.items[3].0.text = answers[3].text
  }

  @objc private func goNext(_ sender: UIButton) {
    let currentAnswers = questions[questionIndex].answers
    if self.items[0].1.isOn {
      self.answersChosen.append(currentAnswers[0])
    }
    if self.items[1].1.isOn {
      self.answersChosen.append(currentAnswers[1])
    }
    if self.items[2].1.isOn {
      self.answersChosen.append(currentAnswers[2])
    }
    if self.items[3].1.isOn {
      self.answersChosen.append(currentAnswers[3])
    }
    self.nextQuestion()
  }

  private func nextQuestion() {
    self.navigationController?.pushViewController(ResultsViewController(responses: self.answersChosen), animated: true)
  }
  
}
