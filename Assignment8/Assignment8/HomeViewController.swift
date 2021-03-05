//
//  HomeViewController.swift
//  Assignment8
//
//  Created by Takayasu Nasu on 2021/03/03.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {

  let mainStackView: UIStackView = {
    let main = UIStackView()
    main.axis = .vertical
    main.alignment = .center
    main.distribution = .fillEqually
    return main
  }()

  let toSaizeriyaButton: UIButton = {
    let button = UIButton()
    button.setTitle("go to Saizeriya", for: .normal)
    button.addTarget(
      self,
      action: #selector(toSaizeriya),
      for: .touchUpInside
    )
    button.setTitleColor(.systemBlue, for: .normal)
    button.layer.cornerRadius = 6
    return button
  }()


  let toTimHortonButton: UIButton = {
    let button = UIButton()
    button.setTitle("go to Tim Horton", for: .normal)
    button.addTarget(
      self,
      action: #selector(toTimHorton),
      for: .touchUpInside
    )
    button.setTitleColor(.systemBlue, for: .normal)
    button.layer.cornerRadius = 6
    return button
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    super.view.backgroundColor = .systemBackground
    self.setUI()
  }

}

extension HomeViewController {

  private func setUI() {
    super.view.addSubview(self.mainStackView)
    self.mainStackView.snp.makeConstraints { (make) -> Void in
      make.top.leading
        .equalTo(super.view.safeAreaLayoutGuide)
        .offset(50)
      make.bottom.trailing
        .equalTo(super.view.safeAreaLayoutGuide)
        .offset(-50)
    }
    self.mainStackView.addArrangedSubview(self.toSaizeriyaButton)
    self.mainStackView.addArrangedSubview(self.toTimHortonButton)

    self.toSaizeriyaButton.snp.makeConstraints { make -> Void in
      make.width.equalToSuperview().multipliedBy(0.5)
    }
  }

  @objc private func toSaizeriya() {
    super.navigationController?.pushViewController(MainViewController(), animated: true)
  }
  
  @objc private func toTimHorton() {
    super.navigationController?.pushViewController(TimHorthonViewController(), animated: true)
  }
}
