//
//  Order.swift
//  mall (iOS)
//
//  Created by eumendies on 2023/5/15.
//

import Foundation

class Order: Identifiable {
    public var id: Int64
    public var book: Book
    public var userID: Int64
    public var number: Int64
    public var time: String
    public var hasPaid: String
    
    init(id: Int64, book: Book, number: Int64, time: String, hasPaid: String, userID: Int64) {
        self.id = id
        self.book = book
        self.number = number
        self.time = time
        self.hasPaid = hasPaid
        self.userID = userID
    }
}
