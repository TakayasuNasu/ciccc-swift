//
//  TagCollectionViewCell.swift
//  Assignment8
//
//  Created by Takayasu Nasu on 2021/02/06.
//

import UIKit
import SnapKit

class TagCollectionViewCell: UICollectionViewCell {

  let tagLabel: UILabel = {
    let label = UILabel()
    label.textColor = .systemBlue
    return label
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
    super.contentView.addSubview(self.tagLabel)
    self.tagLabel.snp.makeConstraints { (make) -> Void in
      make.center.equalToSuperview()
    }
  }


}
