//
//  BookDetailViewModel.swift
//  mall
//
//  Created by eumendies on 2023/5/19.
//

import Foundation
import SQLite

class BookDetailViewModel {
    private var user: User
    
    init(user: User) {
        self.user = user
    }
    
    // 如果hasPaid为yes，则添加到历史订单，如果为no，添加到购物车
    func addOrder(book: Book, number: Int64, hasPaid: String) {
        let today = Date()
        let zone = NSTimeZone.system
        let interval = zone.secondsFromGMT()
        let now = today.addingTimeInterval(TimeInterval(interval))
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        let time = dateformatter.string(from: now)
        do {
            let path = Bundle.main.url(forResource: "test", withExtension: ".db")
            let db = try Connection(path!.path)
            let orders = Table("orders")
            let c_bookID = Expression<Int64>("bookID")
            let c_userID = Expression<Int64>("userID")
            let c_number = Expression<Int64>("number")
            let c_time = Expression<String>("time")
            let c_hasPaid = Expression<String>("hasPaid")
            try db.run(orders.insert(c_bookID <- book.id, c_userID <- self.user.id, c_number <- number, c_time <- time, c_hasPaid <- hasPaid))
            
        } catch {
            print("\(error)")
        }
    }
}
