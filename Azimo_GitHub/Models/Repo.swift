//
//  Repo.swift
//  Azimo_GitHub
//
//  Created by Nikita Gura on 4/30/19.
//  Copyright © 2019 Nikita Gura. All rights reserved.
//

import Foundation

struct Repo:Codable{
    var name: String
    var description: String?
    var watchers: Int
    var stars: Int
    var language: String?
    
    enum CodingKeys: String, CodingKey {
      case watchers  = "watchers"
      case name = "name"
      case stars = "stargazers_count"
      case description = "description"
      case language = "language"
    }
    
}
