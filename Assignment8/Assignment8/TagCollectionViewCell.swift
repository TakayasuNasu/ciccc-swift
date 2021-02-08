//
//  TagCollectionViewCell.swift
//  Assignment8
//
//  Created by Takayasu Nasu on 2021/02/06.
//

import UIKit
import SnapKit

class TagCollectionViewCell: UICollectionViewCell {

  let tagButton: UIButton = {
    let button = UIButton()
    button.setTitleColor(.systemBlue, for: .normal)
    button.layer.cornerRadius = 6
    return button
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    super.contentView.backgroundColor = .systemGray6
    self.setUI()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setUI() {
    super.contentView.addSubview(self.tagButton)
    self.tagButton.snp.makeConstraints { (make) -> Void in
      make.top.leading.equalToSuperview().offset(5)
      make.bottom.trailing.equalToSuperview().offset(-5)
    }
  }


}
