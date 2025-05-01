//
//  Goals.swift
//  VitalityBoost
//
//  Created by Sam on 5/1/25.
//

import Foundation
import Firebase
import SwiftUI

struct Goals {

  var date: String
  var description: String
  var title: String

  var dictionary: [String: Any] {
    return [
      "date": date,
      "description": description,
      "title": title
    ]
  }

}

extension Goals: DocumentSerializable {
    
    init?(dictionary: [String : Any]) {
      guard let date = dictionary["date"] as? String,
            let description = dictionary["description"] as? String,
            let title = dictionary["title"] as? String
        else { return nil }

      self.init(date: date,
                description: description,
                title: title)
    }
    
}
