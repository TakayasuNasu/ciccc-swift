//
//  TimHorthonViewController.swift
//  Assignment8
//
//  Created by Takayasu Nasu on 2021/03/03.
//

import UIKit
import SnapKit

class TimHorthonViewController: UIViewController {

  let viewModel = TimHortonViewModel()
  var dataSource: UICollectionViewDiffableDataSource<Food.Category, Food>!

  // MARK: Setting SearchController.
  private lazy var searchController: UISearchController = {
    let searchController = UISearchController(searchResultsController: nil)
    searchController.searchBar.delegate = self
    searchController.searchResultsUpdater = self
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = "Search menu"
    searchController.searchBar.barTintColor = UIColor(hex: "C8112E")
    definesPresentationContext = true
    return searchController
  }()

  let gridCollectionView : UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    let collectionView = UICollectionView(
      frame: .zero,collectionViewLayout: layout
    )
    collectionView.backgroundColor = UIColor(hex: "C8112E")
    collectionView.register(
      TimHortonGridCollectionViewCell.self,
      forCellWithReuseIdentifier: TimHortonGridCollectionViewCell.reuseIdentifier)
    collectionView.register(
      BasicHeaderView.self,
      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
      withReuseIdentifier: TimHortonGridCollectionViewCell.headerReuseIdentifier
    )
    return collectionView
  }()

  // MARK: SnapShort
  var snapShot: NSDiffableDataSourceSnapshot<Food.Category, Food> {
    var snapshot = NSDiffableDataSourceSnapshot<Food.Category, Food>()
    for section in Food.Category.allCases {
      snapshot.appendSections([section])
      snapshot.appendItems(self.viewModel.foods.filter { food in
        food.category == section
      })
    }
    return snapshot
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    super.view.backgroundColor = UIColor(hex: "C8112E")
    super.title = "Tim Horthon"
    super.navigationItem.searchController = self.searchController
    super.navigationController!.navigationBar.tintColor = .white
    let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
    super.navigationController?.navigationBar.titleTextAttributes = textAttributes
    super.navigationController?.navigationBar.barTintColor = UIColor(hex: "C8112E")
    self.setupUI()
    self.createDataSouce()
  }

}

extension TimHorthonViewController {

  private func setupUI() {
    super.view.addSubview(self.gridCollectionView)
    self.gridCollectionView
      .snp.makeConstraints { make -> Void in
        make
          .top
          .bottom
          .leading
          .trailing
          .equalTo(super.view.safeAreaLayoutGuide)
      }
    self.gridCollectionView
      .setCollectionViewLayout(
        self.createLayout(),
        animated: false
      )
  }

  private func createDataSouce() {
    self.dataSource = UICollectionViewDiffableDataSource<Food.Category, Food>(
      collectionView: self.gridCollectionView,
      cellProvider: { (
        collectionView,
        indexPath,
        food
      ) -> UICollectionViewCell? in
        let cell = self.gridCollectionView.dequeueReusableCell(
          withReuseIdentifier: TimHortonGridCollectionViewCell.reuseIdentifier,
          for: indexPath
        ) as! TimHortonGridCollectionViewCell
        cell.thumbnail.kf.setImage(with: food.image)
        cell.name.text = food.name
        cell.category.text = food.category.rawValue
        cell.time.text = food.time
        cell.price.text = food.price.rawValue
        return cell
      }
    )
    dataSource.supplementaryViewProvider = {
      (collectionView: UICollectionView,
       kind: String,
       indexPath: IndexPath) -> UICollectionReusableView? in
      let header = collectionView.dequeueReusableSupplementaryView(
        ofKind: kind,
        withReuseIdentifier: TimHortonGridCollectionViewCell.headerReuseIdentifier,
        for: indexPath
      ) as! BasicHeaderView
      header.label.text = Food.Category.allCases[indexPath.section].rawValue
      return header
    }
    self.dataSource.apply(self.snapShot)
  }

  private func createLayout() -> UICollectionViewLayout {
    let spacing: CGFloat = 10
    let itemSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(CGFloat(self.viewModel.itemWidth)),
      heightDimension: .fractionalHeight(1.0)
    )
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: spacing, bottom: 0, trailing: spacing)

    let groupSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .absolute(CGFloat(self.viewModel.groupHeight))
    )

    let group = NSCollectionLayoutGroup.horizontal(
      layoutSize: groupSize,
      subitem: item,
      count: self.viewModel.groupCount
    )
    group.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: 0, bottom: 0, trailing: 0)

    let section = NSCollectionLayoutSection(group: group)
    let headerSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .absolute(35)
    )
    let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
      layoutSize: headerSize,
      elementKind: UICollectionView.elementKindSectionHeader,
      alignment: .top
    )

    section.boundarySupplementaryItems = [sectionHeader]

    return UICollectionViewCompositionalLayout(section: section)
  }
}

extension TimHorthonViewController: UISearchResultsUpdating {

  func updateSearchResults(for searchController: UISearchController) {
    if let text = searchController.searchBar.text, !text.isEmpty {
      self.viewModel.searchTextSubscriber.send(text)
    } else {
      self.viewModel.foods = self.viewModel.food.all() as! [Food]
    }
    self.gridCollectionView.reloadData()
    self.dataSource.apply(self.snapShot)
  }
}

extension TimHorthonViewController: UISearchBarDelegate {

  func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
    print(selectedScope)
  }
}

extension UIColor {
  convenience init(hex: String, alpha: CGFloat = 1.0) {
    let v = Int("000000" + hex, radix: 16) ?? 0
    let r = CGFloat(v / Int(powf(256, 2)) % 256) / 255
    let g = CGFloat(v / Int(powf(256, 1)) % 256) / 255
    let b = CGFloat(v / Int(powf(256, 0)) % 256) / 255
    self.init(red: r, green: g, blue: b, alpha: min(max(alpha, 0), 1))
  }
}
