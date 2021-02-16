//
//  HomeCollectionViewController.swift
//  Habits
//
//  Created by Takayasu Nasu on 2021/02/13.
//

import UIKit

private let reuseIdentifier = "Cell"

class HomeCollectionViewController: UICollectionViewController {

  typealias DataSourceType = UICollectionViewDiffableDataSource<ViewModel.Section, ViewModel.Item>

  enum ViewModel {
    enum Section: Equatable, Hashable {
      case leaderboard
      case followedUsers
    }

    enum Item: Equatable, Hashable {
      case leaderboardHabit(name: String, leadingUserRanking: String?, secondaryUserRanking: String?)
      case followedUser(_ user: User, message: String)
    }
  }

  struct Model {
    var usersByID = [String: User]()
    var habitsByName = [String: Habit]()
    var habitStatistics = [HabitStatistics]()
    var userStatistics = [UserStatistics]()

    var currentUser: User {
      return Settings.shared.currentUser
    }

    var users: [User] {
      return Array(usersByID.values)
    }
    var habits: [Habit] {
      return Array(habitsByName.values)
    }

    var followedUsers: [User] {
      return Array(usersByID.filter { Settings.shared.followedUserIDs.contains($0.key) }.values)
    }

    var favoriteHabits: [Habit] {
      return Settings.shared.favoriteHabits
    }

    var nonFavoriteHabits: [Habit] {
      return habits.filter { !favoriteHabits.contains($0) }
    }
  }

  // MARK: - Properties
  var updateTimer: Timer?
  var model = Model()
  var dataSource: DataSourceType!

  // MARK: - Life Cycle Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    self.dataSource = self.createDataSource()
    super.collectionView.dataSource = self.dataSource
    super.collectionView.collectionViewLayout = self.createLayout()

    UserRequest().send { result in
      switch result {
      case .success(let users):
        self.model.usersByID = users
      case .failure:
        break;
      }

      DispatchQueue.main.async {
        self.updateCollectionView()
      }
    }

    HabitRequest().send { result in
      switch result {
      case .success(let habits):
        self.model.habitsByName = habits
      case .failure:
        break;
      }

      DispatchQueue.main.async {
        self.updateCollectionView()
      }
    }
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    update()

    updateTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
      self.update()
    }
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)

    updateTimer?.invalidate()
    updateTimer = nil
  }

}

extension HomeCollectionViewController {

  func updateCollectionView() {

  }

  func update() {
    CombinedStatisticsRequest().send { result in
      switch result {
      case .success(let combinedStatistics):
        self.model.userStatistics = combinedStatistics.userStatistics
        self.model.habitStatistics = combinedStatistics.habitStatistics
      case .failure:
        self.model.userStatistics = []
        self.model.habitStatistics = []
      }

      DispatchQueue.main.async {
        self.updateCollectionView()
      }
    }
  }

  func createDataSource() -> DataSourceType {
    let dataSource = DataSourceType(collectionView: collectionView) {
      (collectionView, indexPath, item) -> UICollectionViewCell? in
      switch item {
      case .leaderboardHabit(let name, let leadingUserRanking, let secondaryUserRanking):
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LeaderboardHabit", for: indexPath) as!  LeaderboardHabitCollectionViewCell
        cell.habitNameLabel.text = name
        cell.leaderLabel.text = leadingUserRanking
        cell.secondaryLabel.text = secondaryUserRanking
        return cell
      default:
        return nil
      }
    }

    return dataSource
  }

  func createLayout() -> UICollectionViewCompositionalLayout {
    let layout = UICollectionViewCompositionalLayout { (sectionIndex, environment) -> NSCollectionLayoutSection? in
      switch self.dataSource.snapshot().sectionIdentifiers[sectionIndex] {
      case .leaderboard:
        let leaderboardItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.3))
        let leaderboardItem = NSCollectionLayoutItem(layoutSize: leaderboardItemSize)

        let verticalTrioSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.75), heightDimension: .fractionalWidth(0.75))
        let leaderboardVerticalTrio = NSCollectionLayoutGroup.vertical(layoutSize: verticalTrioSize, subitem: leaderboardItem, count: 3)

        let leaderboardSection = NSCollectionLayoutSection(group: leaderboardVerticalTrio)
        leaderboardSection.interGroupSpacing = 20
        leaderboardSection.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0)

        leaderboardSection.orthogonalScrollingBehavior = .groupPagingCentered
        leaderboardSection.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 0, bottom: 20, trailing: 0)

        return leaderboardSection
      default:
        return nil
      }
    }

    return layout
  }
}
