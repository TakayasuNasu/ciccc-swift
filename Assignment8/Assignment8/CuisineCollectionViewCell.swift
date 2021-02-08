//
//  CuisineCollectionViewCell.swift
//  Assignment8
//
//  Created by Takayasu Nasu on 2021/02/05.
//

import UIKit
import SnapKit
import Kingfisher

class CuisineCollectionViewCell: UICollectionViewCell {

  var cuisin: Cuisine = Cuisine()

  let mainVisual: UIImageView = {
    let img = UIImageView()
    img.contentMode = .scaleAspectFill
    img.clipsToBounds = true
    return img
  }()

  let menu: UIStackView = {
      let main = UIStackView()
      main.axis = .horizontal
      main.alignment = .center
      main.distribution = .equalSpacing
      return main
  }()

  let name = UILabel()
  let price = UILabel()

  let tagNames: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 12.0)
    return label
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    super.contentView.backgroundColor = .white
    self.setUI()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setUI() {
    super.contentView.addSubview(self.mainVisual)
    self.mainVisual.snp.makeConstraints { (make) -> Void in
      make.top.leading.trailing.equalToSuperview()
      make.height.equalToSuperview().multipliedBy(0.7)
    }

    super.contentView.addSubview(self.menu)
    self.menu.snp.makeConstraints { (make) -> Void in
      make.top.equalToSuperview().offset(super.contentView.bounds.height * 0.7)
      make.leading.equalToSuperview().offset(10)
      make.trailing.equalToSuperview().offset(-10)
      make.height.equalToSuperview().multipliedBy(0.16)
    }

    self.menu.addArrangedSubview(self.name)
    self.menu.addArrangedSubview(self.price)

    super.contentView.addSubview(self.tagNames)
    self.tagNames.snp.makeConstraints { (make) -> Void in
      make.bottom.equalToSuperview()
      make.leading.equalToSuperview().offset(10)
      make.height.equalToSuperview().multipliedBy(0.14)
    }
  }
}
