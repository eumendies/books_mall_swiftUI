//
//  BooksView.swift
//  mall (iOS)
//
//  Created by eumendies on 2023/5/15.
//

import SwiftUI

struct BooksView: View {
    @ObservedObject var booksViewModel: BooksViewModel
    @State private var selectedCategory: String
    @State private var displayBooks: [Book]
    private var categories: [String]
    private var user: User
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    init(viewModel: BooksViewModel, user: User) {
        booksViewModel = viewModel
        categories = viewModel.categories
        selectedCategory = viewModel.categories[0]
        displayBooks = viewModel.booksOf(category: viewModel.categories[0])
        self.user = user
    }
    
    var body: some View {
        ZStack {
            Color(red: 0.9, green: 0.9, blue: 0.9, opacity: 0.8)
                .ignoresSafeArea()
            
            VStack {
                self.category_menu
                self.all_book
            }
        }
    }
    
    // 类别选择菜单
    var category_menu: some View {
        HStack {
            Menu {
                ForEach (0..<categories.count) {index in
                    Button(categories[index]) {
                        changeCategory(index: index)
                    }
                }
            } label: {
                Label("类别: \(selectedCategory)", systemImage: "chevron.down.square")
            }
        }
    }
    
    // 展示的所有书籍
    var all_book: some View {
        ScrollView {
            LazyVGrid (columns: columns) {
                ForEach (displayBooks) { book in
                    bookInfoCard(book: book, user: self.user).padding(.bottom)
                }
            }
            .frame(alignment: .top)
            .padding(.top, 8)
        }
        .padding(.leading, 5)
    }
    
    func changeCategory(index: Int) {
        selectedCategory = categories[index]
        displayBooks = booksViewModel.booksOf(category: categories[index])
    }
}


// 每本书籍的简略信息
struct bookInfoCard: View {
    private var book: Book
    private var user: User
    
    init(book: Book, user: User) {
        self.book = book
        self.user = user
    }
    
    var body: some View {
        NavigationLink(destination: BookDetailView(book: self.book, viewModel: BookDetailViewModel(user: self.user))) {
            VStack {
                Image(book.name)
                    .resizable()
                    .frame(width: 130, height: 100)
                Text("书名：\(book.name)")
                    .padding(1)
                Text("作者：\(book.author)")
                    .padding(1)
                Text("¥" + String(format:"%.2f", book.price))
                    .font(.title2)
                    .foregroundColor(Color.red)
                    .padding(1)
                    .frame(maxWidth: 130, alignment: .leading)
            }
            .padding()
            .frame(minWidth: 130, minHeight: 100, alignment: .topLeading)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: 5)
        }
        .foregroundColor(Color.black)
    }
}


struct BooksView_Previews: PreviewProvider {
    static var previews: some View {
        BooksView(viewModel: BooksViewModel(), user: User())
    }
}
