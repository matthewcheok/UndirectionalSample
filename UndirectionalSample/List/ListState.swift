//
//  ListState.swift
//  UndirectionalSample
//
//  Created by Matthew Cheok on 4/4/19.
//  Copyright © 2019 Matthew Cheok. All rights reserved.
//

import Foundation

struct ListState {
  let title: String
  var items: [JobPosition] = []
}

extension ListState {
  static var initial: ListState {
    return .init(title: "SF Job Positions", items: [])
  }
}

extension ListState {
  enum Mutation {
    case loaded(items: [JobPosition])
    case clear
  }

  mutating func apply(_ mutation: Mutation) {
    switch mutation {
    case .loaded(items: let items):
      self.items = items
    case .clear:
      self.items = []
    }
  }
}
