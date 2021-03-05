//
//  DefaultData.swift
//  Assignment8
//
//  Created by Takayasu Nasu on 2021/02/05.
//

import Foundation

protocol DefaultData {
  associatedtype Default
  static var data: [Default] { get }
}

struct Cuisines: DefaultData {

  static var data: [Cuisine] = [
    Cuisine(id: 1, name: "Milanese doria", image: URL(string: "https://ikujipapa.net/wp-content/uploads/2018/12/saizeriya_01.jpg")!, price: 12, tags: [1, 2, 3]),
    Cuisine(id: 2, name: "Peperoncino", image: URL(string: "https://ikujipapa.net/wp-content/uploads/2018/12/saizeriya_02.jpg")!, price: 34, tags: [4, 5, 6]),
    Cuisine(id: 3, name: "Margherita", image: URL(string: "https://ikujipapa.net/wp-content/uploads/2018/12/saizeriya_03.jpg")!, price: 7, tags: [4, 2, 3]),
    Cuisine(id: 4, name: "Carbonara", image: URL(string: "https://ikujipapa.net/wp-content/uploads/2018/12/saizeriya_04.jpg")!, price: 9, tags: [5, 2, 3]),
    Cuisine(id: 5, name: "Tomato cream risotto", image: URL(string: "https://ikujipapa.net/wp-content/uploads/2018/12/saizeriya_05.jpg")!, price: 14, tags: [6, 2, 3]),
    Cuisine(id: 6, name: "Seafood au gratin", image: URL(string: "https://ikujipapa.net/wp-content/uploads/2018/12/saizeriya_06.jpg")!, price: 16, tags: [1, 2, 4]),
    Cuisine(id: 7, name: "Tarako Sauce Sicilian Style", image: URL(string: "https://ikujipapa.net/wp-content/uploads/2018/12/saizeriya_07.jpg")!, price: 12, tags: [1, 2, 5]),
    Cuisine(id: 8, name: "Grilled Young Chicken", image: URL(string: "https://ikujipapa.net/wp-content/uploads/2018/12/saizeriya_08.jpg")!, price: 2, tags: [1, 2, 6]),
    Cuisine(id: 9, name: "Meat Sauce Bolonia Style", image: URL(string: "https://ikujipapa.net/wp-content/uploads/2018/12/saizeriya_09.jpg")!, price: 5, tags: [1, 5, 3]),
    Cuisine(id: 10, name: "Vegetable and Mushroom Pizza", image: URL(string: "https://ikujipapa.net/wp-content/uploads/2018/12/saizeriya_10.jpg")!, price: 33, tags: [1, 6, 3])
  ]

}

struct Tags: DefaultData {

  static var data: [Tag] = [
    Tag(id: 1, name: "pasta"),
    Tag(id: 2, name: "pizza"),
    Tag(id: 3, name: "grilled"),
    Tag(id: 4, name: "breakfast"),
    Tag(id: 5, name: "lunch"),
    Tag(id: 6, name: "dinner"),
  ]
}

struct Foods: DefaultData {

  static var data: [Food] = [
    Food(
      id: 1,
      name: "Hot Coffee",
      category: Food.Category.hotDrink,
      time: "5",
      price: Food.Rank.cheap,
      image: URL(string: "https://company.timhortons.ca/ca/images/original-blend-product.png")!
    ),
    Food(
      id: 2,
      name: "Iced Coffee",
      category: Food.Category.icedDrink,
      time: "70",
      price: Food.Rank.cheap,
      image: URL(string: "https://company.timhortons.ca/ca/images/dark-roast-product-v2.png")!
    ),
    Food(
      id: 3,
      name: "Tea",
      category: Food.Category.hotDrink,
      time: "0",
      price: Food.Rank.cheap,
      image: URL(string: "https://company.timhortons.ca/ca/images/original-blend-product.png")!
    ),
    Food(
      id: 4,
      name: "Bagel",
      category: Food.Category.breakfast,
      time: "560",
      price: Food.Rank.expensive,
      image: URL(string: "https://company.timhortons.ca/ca/images/toasted-bagel-and-cream-cheese-product.png")!
    ),
    Food(
      id: 5,
      name: "Chili",
      category: Food.Category.lunch,
      time: "330",
      price: Food.Rank.expensive,
      image: URL(string: "https://company.timhortons.ca/ca/images/chili-product.png")!
    ),
    Food(
      id: 6,
      name: "Chips",
      category: Food.Category.snack,
      time: "220",
      price: Food.Rank.expensive,
      image: URL(string: "https://company.timhortons.ca/ca/images/original-blend-product.png")!
    ),
    Food(
      id: 7,
      name: "Cookies",
      category: Food.Category.snack,
      time: "210",
      price: Food.Rank.expensive,
      image: URL(string: "https://company.timhortons.ca/ca/images/cookies-product.png")!
    ),
    Food(
      id: 8,
      name: "Donuts",
      category: Food.Category.donuts,
      time: "190",
      price: Food.Rank.expensive,
      image: URL(string: "https://company.timhortons.ca/ca/images/donuts-product.png")!
    ),
    Food(
      id: 9,
      name: "Pasta",
      category: Food.Category.lunch,
      time: "490",
      price: Food.Rank.expensive,
      image: URL(string: "https://company.timhortons.ca/ca/images/original-blend-product.png")!
    ),
    Food(
      id: 10,
      name: "Soup",
      category: Food.Category.soup,
      time: "120",
      price: Food.Rank.cheap,
      image: URL(string: "https://company.timhortons.ca/ca/images/homestyle-oatmeal-product.png")!
    ),
    Food(
      id: 11,
      name: "Timbits",
      category: Food.Category.donuts,
      time: "70",
      price: Food.Rank.cheap,
      image: URL(string: "https://company.timhortons.ca/ca/images/timbits-product.png")!
    ),
    Food(
      id: 12,
      name: "Chicken Wrap",
      category: Food.Category.wrap,
      time: "430",
      price: Food.Rank.expensive,
      image: URL(string: "https://company.timhortons.ca/ca/images/Grilled-Sausage-Breakfast-Wrap_CAN_2017-sunshine.png")!
    ),
    Food(
      id: 13,
      name: "Steak Wrap",
      category: Food.Category.wrap,
      time: "430",
      price: Food.Rank.expensive,
      image: URL(string: "https://company.timhortons.ca/ca/images/Grilled-Sausage-Breakfast-Wrap_CAN_2017-sunshine.png")!
    )
  ]
}
