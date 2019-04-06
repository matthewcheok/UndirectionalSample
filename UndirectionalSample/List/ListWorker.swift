//
//  ListWorker.swift
//  UndirectionalSample
//
//  Created by Matthew Cheok on 4/4/19.
//  Copyright © 2019 Matthew Cheok. All rights reserved.
//

import UIKit

protocol ListViewActing: AnyObject {
  func presentDetailViewController(_ viewController: UIViewController)
}

final class ListWorker {
  weak var actor: ListViewActing?

  let store: ListStore

  init(store: ListStore, actor: ListViewActing) {
    self.store = store
    self.actor = actor
  }

  private let apiAdapter = APIAdapter()

  func reloadData() {
    apiAdapter.fetchJobPositions { (result) in
      switch result {
      case .success(let items):
        self.store.handle(.loaded(items: items))

      case .failure(let error):
        print(error)
      }
    }
  }

  func didSelectRow(at index: Int) {
    let item = store.state.items[index]
    let viewController = DetailViewController(item: item)
    actor?.presentDetailViewController(viewController)
  }
}
