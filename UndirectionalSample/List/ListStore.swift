//
//  ListStore.swift
//  UndirectionalSample
//
//  Created by Matthew Cheok on 4/4/19.
//  Copyright © 2019 Matthew Cheok. All rights reserved.
//

import Foundation

protocol ListStateRendering: AnyObject {
  func setState(_ state: ListState)
}

final class ListStore {
  weak var renderer: ListStateRendering?

  private(set) var state = ListState.initial {
    didSet {
      renderer?.setState(state)
    }
  }

  init(renderer: ListStateRendering) {
    self.renderer = renderer
    renderer.setState(state)
  }

  func handle(_ mutation: ListState.Mutation) {
    state.apply(mutation)
  }
}
