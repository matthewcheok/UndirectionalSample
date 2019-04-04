//
//  Models.swift
//  UndirectionalSample
//
//  Created by Matthew Cheok on 4/3/19.
//  Copyright © 2019 Matthew Cheok. All rights reserved.
//

import Foundation

struct JobPosition: Codable {
  let id: String
  let title: String
  let location: String
  let description: String
}
