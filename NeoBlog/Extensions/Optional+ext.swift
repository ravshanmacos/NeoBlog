//
//  Optional+ext.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 15/02/24.
//

import Foundation

extension Optional {
    var isEmpty: Bool {
      return self == nil
    }

    var exists: Bool {
      return self != nil
    }
}
