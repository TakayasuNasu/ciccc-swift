//
//  HabitDetailViewController.swift
//  Habits
//
//  Created by Takayasu Nasu on 2021/02/13.
//

import UIKit

class HabitDetailViewController: UIViewController {


  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var categoryLabel: UILabel!
  @IBOutlet weak var infoLabel: UILabel!
  @IBOutlet weak var collectionView: UICollectionView!
  
  
  typealias DataSourceType = UICollectionViewDiffableDataSource<ViewModel.Section, ViewModel.Item>

  enum ViewModel {
    enum Section: Hashable {
      case leaders(count: Int)
      case remaining
    }

    enum Item: Hashable, Comparable {
      case single(_ stat: UserCount)
      case multiple(_ stats: [UserCount])

      static func < (lhs: HabitDetailViewController.ViewModel.Item, rhs: HabitDetailViewController.ViewModel.Item) -> Bool {
        switch (lhs, rhs) {
        case (.single(let lCount), .single(let rCount)):
          return lCount.count < rCount.count
        case (.multiple(let lCounts), .multiple(let rCounts)):
          return lCounts.first!.count < rCounts.first!.count
        case (.single, .multiple):
          return false
        case (.multiple, .single):
          return true
        }
      }
    }
  }

  struct Model {
    var habitStatistics: HabitStatistics?
    var userCounts: [UserCount] {
      habitStatistics?.userCounts ?? []
    }
  }

  // MARK: - Properties
  var updateTimer: Timer?
  var dataSource: DataSourceType!
  var model = Model()
  var habit: Habit!

  // MARK: - Life Cycle Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    self.dataSource = self.createDataSource()
    self.collectionView.dataSource = self.dataSource
    self.collectionView.collectionViewLayout = self.createLayout()
    self.update()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.update()
    self.updateTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
      self.update()
    }
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    self.updateTimer?.invalidate()
    self.updateTimer = nil
  }

}

extension HabitDetailViewController {
  func update() {
    HabitStatisticsRequest(habitNames: [self.habit.name]).send { result in
      if case .success(let statistics) = result, statistics.count > 0 {
        self.model.habitStatistics = statistics[0]
      } else {
        self.model.habitStatistics = nil
      }

      DispatchQueue.main.async {
        self.updateCollectionView()
      }
    }
  }

  func updateCollectionView() {
    let items = (self.model.habitStatistics?.userCounts.map { ViewModel.Item.single($0) } ?? []).sorted(by: >)

    dataSource.applySnapshotUsing(sectionIDs: [.remaining],itemsBySection: [.remaining: items])
  }

  func createDataSource() -> DataSourceType {
    return DataSourceType(collectionView: self.collectionView) { (collectionView, indexPath, grouping) -> UICollectionViewCell? in
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserCount", for: indexPath) as!  PrimarySecondaryTextCollectionViewCell

      switch grouping {
      case .single(let userStat):
        cell.primaryTextLabel.text = userStat.user.name
        cell.secondaryTextLabel.text = "\(userStat.count)"
      default:
        break
      }

      return cell
    }
  }

  func createLayout() -> UICollectionViewCompositionalLayout {
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    item.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12)

    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(44))
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)

    let section = NSCollectionLayoutSection(group: group)
    section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0)

    return UICollectionViewCompositionalLayout(section: section)
  }
}
