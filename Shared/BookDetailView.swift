//
//  BookDetailView.swift
//  mall (iOS)
//
//  Created by eumendies on 2023/5/15.
//

import SwiftUI

struct BookDetailView: View {
    @State private var number: Int64 = 0
    private var book: Book
    private var viewModel: BookDetailViewModel
    @State private var showAlert1: Bool = false
    @State private var showAlert2: Bool = false
    
    init(book: Book, viewModel: BookDetailViewModel) {
        self.book = book
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            Color(red: 0.9, green: 0.9, blue: 0.9, opacity: 0.8)
                .ignoresSafeArea()
            
            VStack {
                Image(book.name)
                    .resizable()
                    .frame(minWidth:100, minHeight: 80)
                    .background(Color.gray)
                    .cornerRadius(20)
                    .aspectRatio(contentMode: .fit)
                    .shadow(radius: 8)
                self.infoCard
                self.buyBar
            }
            .padding()
        }
    }
    
    var infoCard: some View {
        VStack {
            Text("书名：\(book.name)")
                .padding(1)
            Text("作者：\(book.author)")
                .padding(1)
                .padding(1)
            Text("简介：\(book.description)")
                .padding(1)
            Text("¥" + String(format:"%.2f", book.price))
                .font(.title2)
                .foregroundColor(Color.red)
                .padding(1)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding()
        .frame(minWidth:100, maxWidth: .infinity, minHeight: 80, alignment: .center)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 8)
    }
    
    var buyBar: some View {
        VStack {
            Stepper("数量：\(number)", onIncrement: {number = number + 1}, onDecrement: {number = number == 0 ? 0 : number - 1})
                .padding(.leading, 160)
                .padding([.trailing, .top])
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 10.0)
                        .fill(Color.yellow)
                        .shadow(radius: 7)
                    Text("加入购物车")
                }
                .alert(isPresented: $showAlert1) {
                    Alert(title: Text("成功"), message: Text("添加成功！"))
                }
                .onTapGesture {
                    if self.number > 0 {
                        showAlert1 = true
                        self.viewModel.addOrder(book: self.book, number: self.number, hasPaid: "no")
                    }
                }
                .frame(width: 110, height: 35, alignment: .center)
                ZStack {
                    RoundedRectangle(cornerRadius: 10.0)
                        .fill(Color.red)
                        .shadow(radius: 7)
                    Text("购买")
                }
                .alert(isPresented: $showAlert2) {
                    Alert(title: Text("成功"), message: Text("购买成功！"))
                }
                .onTapGesture {
                    if self.number > 0 {
                        showAlert2 = true
                        self.viewModel.addOrder(book: self.book, number: self.number, hasPaid: "yes")
                    }
                }
                .frame(width: 110, height: 35, alignment: .center)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
}

struct BookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BookDetailView(book: Book(id: 0, name: "test", category: "test", author: "test", description: "test", price: 100.0), viewModel: BookDetailViewModel(user: User()))
    }
}
