//
//  BooksViewModel.swift
//  mall (iOS)
//
//  Created by eumendies on 2023/5/17.
//

import Foundation
import SwiftUI
import SQLite

class BooksViewModel: ObservableObject {
    @Published private var books: [Book]
    public var categories: [String]
    
    init() {
        // 连接数据库并取出数据
        var tmp_books: [Book] = []
        var tmp_categories: Set<String> = []
        do {
            let path = Bundle.main.url(forResource: "test", withExtension: ".db")
            let db = try Connection(path!.path)
            let booksData = Table("books")
            let id = Expression<Int64>("id")
            let name = Expression<String>("name")
            let category = Expression<String>("category")
            let author = Expression<String>("author")
            let description = Expression<String>("description")
            let price = Expression<Double>("price")
            

            for book in try db.prepare(booksData) {
                tmp_books.append(Book(id: book[id], name: book[name], category: book[category], author: book[author], description: book[description], price: book[price]))
                tmp_categories.insert(book[category])
            }
        } catch {
            print (error)
        }
        books = tmp_books
        categories = Array(tmp_categories)
    }
    
    // 返回属于某个类别的全部书籍
    func booksOf(category: String) -> [Book] {
        var results: [Book] = []
        for i in 0..<books.count {
            if books[i].category == category {
                results.append(books[i])
            }
        }
        return results
    }
}
