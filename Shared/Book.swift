//
//  Book.swift
//  mall (iOS)
//
//  Created by eumendies on 2023/5/15.
//

import Foundation

class Book: Identifiable {
    public var id: Int64
    public var name: String
    public var category: String
    public var author: String
    public var description: String
    public var price: Double
    
    init(id: Int64, name: String, category: String, author: String, description: String, price: Double) {
        self.id = id
        self.name = name
        self.category = category
        self.author = author
        self.description = description
        self.price = price
    }
}
