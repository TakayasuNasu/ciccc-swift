//
//  ViewController.swift
//  Assignment8
//
//  Created by Takayasu Nasu on 2021/02/05.
//

import UIKit
import RxSwift
import SnapKit

private let reuseIdentifier = "CuisineCell"

class ViewController: UICollectionViewController {

  let cuisine: ViewModel = ViewCuisine(model: Cuisine())

  override func viewDidLoad() {
    super.viewDidLoad()
    super.collectionView.backgroundColor = .systemGray4
    super.collectionView.setCollectionViewLayout(generateLayout(), animated: false)
    super.collectionView.register(CuisineCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
  }

  private func generateLayout() -> UICollectionViewLayout {
    let spacing: CGFloat = 4
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))

    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: spacing, bottom: 0, trailing: spacing)

    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.5))
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
    group.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: 0, bottom: 0, trailing: 0)

    let section = NSCollectionLayoutSection(group: group)
    section.interGroupSpacing = spacing

    return UICollectionViewCompositionalLayout(section: section)
  }

  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }

  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.cuisine.all().count
  }

  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CuisineCollectionViewCell

    let cellData = self.cuisine.all()[indexPath.item] as! Cuisine
    cell.mainVisual.kf.setImage(with: cellData.image)
    cell.name.text = cellData.name
    cell.price.text = "$\(cellData.price)"
    cell.tagNames.text = self.cuisine.attribute(indexPath.item + 1)
    return cell
  }

}

