//
//  DetailsViewController.swift
//  Assignment4
//
//  Created by 那須毅康 on 2020/12/14.
//  Copyright © 2020 Derrick Park. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

  var city: City!

  let mainStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.alignment = .center
    stackView.distribution = .fillEqually
    return stackView
  }()

  let countryName: UILabel = {
    let text = UILabel()
    text.text = "Countory"
    return text
  }()

  let cityLabel: UILabel = {
    let text = UILabel()
    text.text = "City"
    return text
  }()

  let temperature: UILabel = {
    let text = UILabel()
    text.text = "Temperature"
    return text
  }()

  let summary: UILabel = {
    let text = UILabel()
    text.text = "Summary"
    return text
  }()

  let country: UILabel = UILabel()
  let cityName: UILabel = UILabel()
  let temp: UILabel = UILabel()
  let citySummary: UILabel = UILabel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    self.view.addSubview(mainStackView)
    self.setupStackView()
    self.setupText()
  }

  private func setupStackView() {
    self.mainStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
    self.mainStackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    self.mainStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
    self.mainStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
  }

  private func setupText() {
    self.mainStackView.addArrangedSubview(self.countryName)
    self.mainStackView.addArrangedSubview(self.country)
    self.mainStackView.addArrangedSubview(self.cityLabel)
    self.mainStackView.addArrangedSubview(self.cityName)
    self.mainStackView.addArrangedSubview(self.temperature)
    self.mainStackView.addArrangedSubview(self.temp)
    self.mainStackView.addArrangedSubview(self.summary)
    self.mainStackView.addArrangedSubview(self.citySummary)
    let labels: [UILabel] = [
      self.countryName,
      self.country,
      self.cityLabel,
      self.cityName,
      self.temperature,
      self.temp,
      self.summary,
      self.citySummary
    ]
    for l in labels {
      l.translatesAutoresizingMaskIntoConstraints = false
      l.font = .boldSystemFont(ofSize: 20.0)
    }

    self.country.text = self.getEmoji(icon: self.city.icon)
    self.cityName.text = self.city.name
    self.cityName.font = .systemFont(ofSize: 30.0)
    self.temp.text = String(self.city.temp)
    self.temp.font = .systemFont(ofSize: 30.0)
    self.citySummary.text = String(self.city.summary)
    self.citySummary.font = .systemFont(ofSize: 30.0)
  }

  private func getEmoji(icon: String) -> String {
    switch icon {
    case "canada":
      return "🇨🇦"
    case "italy":
      return "🇮🇹"
    case "japan":
      return "🇯🇵"
    case "brazil":
      return "🇧🇷"
    case "skorea":
      return "🇰🇷"
    default:
      return "🇨🇦"
    }
  }
}
