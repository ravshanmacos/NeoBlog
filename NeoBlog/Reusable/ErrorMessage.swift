//
//  ErrorMessage.swift
//  NeoBlog
//
//  Created by Ravshan Winter on 13/03/24.
//

import Foundation

struct ErrorMessage: Error, Hashable {
    let id: UUID
    let title: String
    let message: String
    
    init(title: String, message: String) {
        self.id = UUID()
        self.title = title
        self.message = message
    }
}
