//
//  TimHortonViewModel.swift
//  Assignment8
//
//  Created by Takayasu Nasu on 2021/03/03.
//

import Foundation
import Combine

class TimHortonViewModel {

  var cancellable = Set<AnyCancellable>()
  let food: ModelProtocol

  var isListLayout: Bool = true
  var thumbnailFractionalHeight: Float = 0.8;
  var searchTextSubscriber = PassthroughSubject<String, Never>()
  lazy var foods: [Food] = self.food.all() as! [Food]

  var itemWidth: Float {
    if self.isListLayout {
      return 0.5
    } else {
      return 1.0
    }
  }

  var groupHeight: Float {
    if self.isListLayout {
      return 280
    } else {
      return 215
    }
  }

  var groupCount: Int {
    if self.isListLayout {
      return 2
    } else {
      return 1
    }
  }

  init(model :ModelProtocol = Food(
    id: 1,
    name: "Timbits",
    category: Food.Category.hotDrink,
    time: "70",
    price: Food.Rank.cheap,
    image: URL(string: "https://company.timhortons.ca/ca/images/timbits-product.pn")
  )) {
    self.food = model

    searchTextSubscriber
      .sink(receiveValue: { letter in
        let foodList = self.food.all()
          .filter { $0.name.localizedCaseInsensitiveContains(letter) }
        self.foods = foodList as! [Food]
      })
      .store(in: &cancellable)
  }
  
}
