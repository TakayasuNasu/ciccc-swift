//
//  ViewModel.swift
//  Assignment8
//
//  Created by Takayasu Nasu on 2021/02/05.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

protocol ViewModel {
  var model: ModelProtocol { get }
  func all() -> [ModelProtocol]
  func attribute(_ id: Int) -> String
}

extension ViewModel {
  func attribute(_ id: Int) -> String {
    fatalError("This method not supporting.")
  }
}

struct ViewCuisine: ViewModel {

  let model: ModelProtocol

  init(model: ModelProtocol) {
    self.model = model
  }

  func all() -> [ModelProtocol] {
    return self.model.all()
  }

  func attribute(_ id: Int) -> String {
    let cuisine = self.model.all().filter { $0.id == id }.first
    let tagList = Tags.data.filter { cuisine!.tags.contains($0.id) }
    let names = tagList.map { $0.name }
    return names.joined(separator: " ")
  }
}

struct MainViewModel: ViewModel {

  var cuisines = BehaviorRelay<[AnimatableSectionModel<Int, Cuisine>]>(value: [AnimatableSectionModel<Int, Cuisine>(model: 0, items: Cuisines.data)])
  let tags = BehaviorRelay<[SectionModel<Int, Tag>]>(value: [SectionModel<Int, Tag>(model: 0, items: Tags.data)])
  var selectedCuisin: Set<Cuisine> = []
  var selectedTag: Set<Int> = []
  var isSingleColumn = false
  var column: Int {
    if self.isSingleColumn {
      return 1
    } else {
      return 2
    }
  }

  var imageHeight: CGFloat {
    if self.isSingleColumn {
      return 0.8
    } else {
      return 0.5
    }
  }

  let model: ModelProtocol
  let cuisine = Cuisine()
  let tag = Tag()

  init() {
    self.model = Tag()
  }

  func all() -> [ModelProtocol] {
    return Tags.data
  }

  mutating func updateCuisins() {
    let data: [Cuisine] = {
      if self.selectedTag.count == 0 {
        return Cuisines.data
      } else {
        self.selectedCuisin = []
        for id in self.selectedTag {
          Cuisines.data.filter { $0.tags.contains(id)}
            .forEach { self.selectedCuisin.insert($0) }
        }
      }
      return Array(self.selectedCuisin)
    }()
    var section: [AnimatableSectionModel<Int, Cuisine>] = []
    section.append(AnimatableSectionModel<Int, Cuisine>(model: 0, items: data))
    self.cuisines.accept(section)
  }

  mutating func updateSelectedTag(id: Int) {
    if self.selectedTag.contains(id) {
      self.selectedTag.remove(id)
    } else {
      self.selectedTag.insert(id)
    }
  }
}
