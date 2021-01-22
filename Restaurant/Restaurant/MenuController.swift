//
//  MenuController.swift
//  Restaurant
//
//  Created by Takayasu Nasu on 2021/01/21.
//

import Foundation

class MenuController {

  static let shared = MenuController()
  let baseURL = URL(string: "http://localhost:8090/")!

  private init() {}

  func fetchCategories(completion: @escaping (Result<[String], Error>) -> Void) {
    let categoriesURL = baseURL.appendingPathComponent("categories")
    let task = URLSession.shared.dataTask(with: categoriesURL) { (data, response, error) in
      if let data = data {
        do {
          let jsonDecoder = JSONDecoder()
          let categoriesResponse = try jsonDecoder.decode(CategoriesResponse.self, from: data)
          completion(.success(categoriesResponse.categories))
        } catch {
          completion(.failure(error))
        }
      } else if let error = error {
        completion(.failure(error))
      }
    }
    task.resume()
  }

  func fetchMenuItems(forCategory categoryName: String, completion: @escaping (Result<[MenuItem], Error>) -> Void) {
    let initialMenuURL = baseURL.appendingPathComponent("menu")
    var components = URLComponents(url: initialMenuURL, resolvingAgainstBaseURL: true)!
    components.queryItems = [URLQueryItem(name: "category", value: categoryName)]
    let menuURL = components.url!
    let task = URLSession.shared.dataTask(with: menuURL) { (data, response, error) in
      if let data = data {
        do {
          let jsonDecoder = JSONDecoder()
          let menuResponse = try jsonDecoder.decode(MenuResponse.self, from: data)
          completion(.success(menuResponse.items))
        } catch {
          completion(.failure(error))
        }
      } else if let error = error {
        completion(.failure(error))
      }
    }
    task.resume()
  }

  typealias MinutesToPrepare = Int

  func submitOrder(forMenuIDs menuIDs: [Int], completion: @escaping (Result<MinutesToPrepare, Error>) -> Void) {
    let orderURL = baseURL.appendingPathComponent("order")
    var request = URLRequest(url: orderURL)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")

    let jsonData = try? JSONEncoder().encode(["menuIds": menuIDs])
    request.httpBody = jsonData
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
      if let data = data {
        do {
          let jsonDecoder = JSONDecoder()
          let orderResponse = try jsonDecoder.decode(OrderResponse.self, from: data)
          completion(.success(orderResponse.prepTime))
        } catch {
          completion(.failure(error))
        }
      } else if let error = error {
        completion(.failure(error))
      }
    }
    task.resume()
  }
}
