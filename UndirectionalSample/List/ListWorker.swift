//
//  ListWorker.swift
//  UndirectionalSample
//
//  Created by Matthew Cheok on 4/4/19.
//  Copyright © 2019 Matthew Cheok. All rights reserved.
//

import UIKit

protocol ListStateRendering: AnyObject {
  func setState(_ state: ListState)
  func presentDetailViewController(_ viewController: UIViewController)
}

final class ListWorker {
  weak var renderer: ListStateRendering?

  var state = ListState(title: "SF Job Positions", items: []) {
    didSet {
      renderer?.setState(state)
    }
  }

  init(renderer: ListStateRendering) {
    self.renderer = renderer
    renderer.setState(state)
  }

  private let apiAdapter = APIAdapter()

  func reloadData() {
    apiAdapter.fetchJobPositions { (result) in
      switch result {
      case .success(let items):
        self.state.items = items

      case .failure(let error):
        print(error)
      }
    }
  }

  func didSelectRow(at index: Int) {
    let item = state.items[index]
    let viewController = DetailViewController(item: item)
    renderer?.presentDetailViewController(viewController)
  }
}
