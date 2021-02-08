//
//  MainViewController.swift
//  Assignment8
//
//  Created by Takayasu Nasu on 2021/02/06.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import SnapKit

let cuisineCellIdentifier = "cuisineCell"
let tagCellIdentifier = "tagCell"

class MainViewController: UIViewController {

  let disposeBag = DisposeBag()
  var viewModel = MainViewModel()

  let cuisineCollectionView: UICollectionView = {
    let viewLayout = UICollectionViewFlowLayout()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
    collectionView.backgroundColor = .systemGray4
    return collectionView
  }()

  let tagCollectionView: UICollectionView = {
    let viewLayout = UICollectionViewFlowLayout()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
    collectionView.backgroundColor = .systemGray4
    return collectionView
  }()

  var cuisinsDataSource: RxCollectionViewSectionedAnimatedDataSource<AnimatableSectionModel<Int, Cuisine>> {
    return RxCollectionViewSectionedAnimatedDataSource<AnimatableSectionModel<Int, Cuisine>>(
      configureCell: { _, collectionView, indexPath, cuisine -> UICollectionViewCell in
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cuisineCellIdentifier, for: indexPath) as! CuisineCollectionViewCell
        cell.mainVisual.kf.setImage(with: cuisine.image)
        cell.name.text = cuisine.name
        cell.price.text = "$\(cuisine.price)"
        cell.tagNames.text = self.viewModel.attribute(indexPath.item + 1)
        return cell
      }
    )
  }

  var tagDataSource: RxCollectionViewSectionedReloadDataSource<SectionModel<Int, Tag>> {
    return RxCollectionViewSectionedReloadDataSource<SectionModel<Int, Tag>>(
      configureCell: { _, collectionView, indexPath, tag -> UICollectionViewCell in
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: tagCellIdentifier, for: indexPath) as! TagCollectionViewCell
        cell.tagButton.setTitle(tag.name, for: .normal)
        return cell
      }
    )
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    super.view.backgroundColor = .systemGray4
    self.cuisineCollectionView.register(CuisineCollectionViewCell.self, forCellWithReuseIdentifier: cuisineCellIdentifier)
    self.cuisineCollectionView.setCollectionViewLayout(self.generateCuisineCollectionViewLayout(), animated: true)
    self.tagCollectionView.register(TagCollectionViewCell.self, forCellWithReuseIdentifier: tagCellIdentifier)
    self.tagCollectionView.setCollectionViewLayout(self.generateTagCollectionViewLayout(), animated: false)
    self.setUI()
    self.bindCuisineCollection()
    self.bindTagCollection()
    self.onSelectedTag()
  }

}

extension MainViewController {

  private func setUI() {
    super.view.addSubview(self.tagCollectionView)
    self.tagCollectionView.snp.makeConstraints { (make) -> Void in
      make.top.equalTo(super.view.safeAreaLayoutGuide)
      make.leading.trailing.equalToSuperview()
      make.height.equalToSuperview().multipliedBy(0.05)
    }

    super.view.addSubview(self.cuisineCollectionView)
    self.cuisineCollectionView.snp.makeConstraints { (make) -> Void in
      make.top.equalTo(super.view.safeAreaLayoutGuide).offset(super.view.bounds.height * 0.06)
      make.leading.trailing.equalToSuperview()
      make.height.equalToSuperview().multipliedBy(0.8)
    }
  }

  private func bindCuisineCollection() {
    self.viewModel.cuisins
      .asDriver()
      .drive(self.cuisineCollectionView.rx.items(dataSource: self.cuisinsDataSource))
      .disposed(by: disposeBag)
  }

  private func bindTagCollection() {
    self.viewModel.tags
      .asDriver()
      .drive(self.tagCollectionView.rx.items(dataSource: self.tagDataSource))
      .disposed(by: disposeBag)
  }

  private func onSelectedTag() {
    self.tagCollectionView.rx.itemSelected
      .subscribe(onNext: { [unowned self] indexPath in
        self.viewModel.updateSelectedTag(id: indexPath.item)
      }).disposed(by: disposeBag)

  }

  private func generateCuisineCollectionViewLayout() -> UICollectionViewLayout {
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

  private func generateTagCollectionViewLayout() -> UICollectionViewLayout {
    let spacing: CGFloat = 4
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))

    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: spacing, bottom: 0, trailing: spacing)

    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(2.2), heightDimension: .fractionalHeight(1))
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 6)
    group.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: 0, bottom: 0, trailing: 0)

    let section = NSCollectionLayoutSection(group: group)
    section.interGroupSpacing = spacing
    return UICollectionViewCompositionalLayout(section: section)
  }

}
