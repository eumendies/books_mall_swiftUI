//
//  ShoppingCarViewModel.swift
//  mall
//
//  Created by eumendies on 2023/5/20.
//

import Foundation
import SQLite

class ShoppingCarViewModel {
    private var userID: Int64
    
    init(userID: Int64) {
        self.userID = userID
    }
    
    func getItems() -> [Order] {
        var result: [Order] = []
        do {
            let path = Bundle.main.url(forResource: "test", withExtension: ".db")
            let db = try Connection(path!.path)
            let orders = Table("orders")
            let c_ID = Expression<Int64>("id")
            let c_bookID = Expression<Int64>("bookID")
            let c_userID = Expression<Int64>("userID")
            let c_number = Expression<Int64>("number")
            let c_time = Expression<String>("time")
            let c_hasPaid = Expression<String>("hasPaid")
            for order in try db.prepare(orders) {
                if order[c_userID] == self.userID && order[c_hasPaid] == "no" {
                    var b: Book = getBookInfo(bookID: order[c_bookID])
                    result.append(Order(id: order[c_ID], book: b, number: order[c_number], time: order[c_time], hasPaid: order[c_hasPaid], userID: order[c_userID]))
                }
            }
        } catch {
            print("\(error)")
        }
        return result
    }
    
    func deleteOrder(orderID: Int64) {
        do {
            let path = Bundle.main.url(forResource: "test", withExtension: ".db")
            let db = try Connection(path!.path)
            let orders = Table("orders")
            let c_ID = Expression<Int64>("id")
            let deleteItem = orders.filter(c_ID == orderID)
            try db.run(deleteItem.delete())
        } catch {
            print("\(error)")
        }
    }
    
    func pay(orderID: Int64) {
        do {
            let path = Bundle.main.url(forResource: "test", withExtension: ".db")
            let db = try Connection(path!.path)
            let orders = Table("orders")
            let c_ID = Expression<Int64>("id")
            let hasPaid = Expression<String>("hasPaid")
            let updateItem = orders.filter(c_ID == orderID)
            try db.run(updateItem.update(hasPaid <- "yes"))
        } catch {
            print("\(error)")
        }
    }
    
    func getBookInfo(bookID: Int64) -> Book {
        do {
            let path = Bundle.main.url(forResource: "test", withExtension: ".db")
            let db = try Connection(path!.path)
            let books = Table("books")
            let c_ID = Expression<Int64>("id")
            let c_name = Expression<String>("name")
            let c_category = Expression<String>("category")
            let c_author = Expression<String>("author")
            let c_description = Expression<String>("description")
            let c_price = Expression<Double>("price")
            let query = books.filter(c_ID == bookID)
            for book in try db.prepare(query) {
                return Book(id: book[c_ID], name: book[c_name], category: book[c_category], author: book[c_author], description: book[c_description], price: book[c_price])
            }
        } catch {
            print("\(error)")
        }
        return Book(id: -1, name: "", category: "", author: "", description: "", price: 0)
    }
}
