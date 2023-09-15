//
//  User.swift
//  mall (iOS)
//
//  Created by eumendies on 2023/5/15.
//

import Foundation

class User: Identifiable {
    public var id: Int64
    public var userName: String
    public var password: String
    
    init(id: Int64, userName: String, password: String) {
        self.id = id
        self.userName = userName
        self.password = password
    }
    
    init() {
        self.id = 1
        self.userName = ""
        self.password = ""
    }
}
