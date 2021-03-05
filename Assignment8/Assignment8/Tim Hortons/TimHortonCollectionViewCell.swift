//
//  TimHortonCollectionViewCell.swift
//  Assignment8
//
//  Created by Takayasu Nasu on 2021/03/04.
//

import UIKit
import SnapKit

class TimHortonGridCollectionViewCell: UICollectionViewCell {

  static let reuseIdentifier: String = "grid"
  static let headerReuseIdentifier = "HeaderStateCell"
  let viewModel = TimHortonViewModel()

  let thumbnail: UIImageView = {
    let imageName: String = ""
    let img = UIImageView(image: UIImage(named: imageName))
    img.contentMode = .scaleAspectFit
    img.clipsToBounds = true
    return img
  }()

  var name = UILabel()
  var category = UILabel()
  var time = UILabel()
  var price = UILabel()

  let stackView: UIStackView = {
    let main = UIStackView()
    main.axis = .vertical
    main.alignment = .center
    main.distribution = .equalSpacing
    return main
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    super.contentView.addSubview(self.stackView)
    self.stackView
      .snp.makeConstraints { make -> Void in
        make
          .top
          .bottom
          .leading
          .trailing
          .equalToSuperview()
      }
    self.stackView.addArrangedSubview(self.thumbnail)
    self.stackView.addArrangedSubview(name)
    self.stackView.addArrangedSubview(category)
    //    self.stackView.addArrangedSubview(time)
    //    self.stackView.addArrangedSubview(price)

    self.thumbnail.snp.makeConstraints { make -> Void in
      make.top.equalToSuperview()
      make.height.equalToSuperview().multipliedBy(
        self.viewModel.thumbnailFractionalHeight
      )
    }
    self.name.snp.makeConstraints { make -> Void in
      make.leading.trailing.equalToSuperview()
      make.height.equalToSuperview().multipliedBy(0.1)
    }
    self.category.snp.makeConstraints { make -> Void in
      make.leading.trailing.equalToSuperview()
      make.height.equalToSuperview().multipliedBy(0.1)
    }
    self.name.textColor = .darkGray
    self.category.textColor = .lightGray
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

class TimHortonListCollectionViewCell: UICollectionViewCell {

  static let reuseIdentifier: String = "list"

}

class BasicHeaderView: UICollectionReusableView {

  let label = UILabel()

  override init(frame: CGRect) {
    super.init(frame: frame)
    addSubview(label)
    backgroundColor = .white
    self.label.snp.makeConstraints { make -> Void in
      make.center.equalToSuperview()
    }
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
