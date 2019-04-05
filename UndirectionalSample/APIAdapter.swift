//
//  APIAdapter.swift
//  UndirectionalSample
//
//  Created by Matthew Cheok on 4/4/19.
//  Copyright © 2019 Matthew Cheok. All rights reserved.
//

import Foundation

final class APIAdapter {
  private let session: URLSession
  private let queue: DispatchQueue

  init(session: URLSession = .shared, queue: DispatchQueue = .main) {
    self.session = session
    self.queue = queue
  }

  func fetchJobPositions(completion: @escaping (Result<[JobPosition], Error>) -> Void)
  {
    guard let url = URL(string: "https://jobs.github.com/positions.json?description=python&location=san+francisco") else {
      return
    }

    session.dataTask(with: url) { (data, response, error) in
      if let error = error {
        self.queue.async {
          completion(.failure(error))
        }
      }

      guard let data = data else { fatalError("There's no error but also no data") }

      let decoder = JSONDecoder()
      do {
        let items = try decoder.decode([JobPosition].self, from: data)
        self.queue.async {
          completion(.success(items))
        }
      } catch {
        self.queue.async {
          completion(.failure(error))
        }
      }
    }.resume()
  }
}
