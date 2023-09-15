//
//  ShoppingCarView.swift
//  mall (iOS)
//
//  Created by eumendies on 2023/5/16.
//

import SwiftUI

struct ShoppingCarView: View {
    private var viewModel: ShoppingCarViewModel
    @State private var cards: [preserveCard] = []
    @State private var showMsg: Bool = false
    @State private var totalPrice: Double = 0
    @State private var toggleIsOn: [Bool] = [true, true, true, true, true, true, true, true, true, true]
    
    init(viewModel: ShoppingCarViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            // background
            Color(red: 0.9, green: 0.9, blue: 0.9, opacity: 0.8)
                .ignoresSafeArea()
            
            // content
            VStack {
                self.items
                self.operation_bar
            }
        }
    }
    
    
    // 展示的所有购物车条目
    var items: some View {
        ScrollView {
            ForEach (self.cards) { card in
                card.padding()
            }
        }
        .onAppear() {
            // 在init中无法对@State的数组进行Append，故在此初始化
            refreshCards()
        }
    }
    
    // 两个操作按钮
    var operation_bar: some View {
        HStack {
            Text("合计：¥ " + String(format:"%.2f", self.totalPrice))
                .frame(minWidth: 150, alignment: .leading)
                .onChange(of: toggleIsOn) { value in
                    getTotalPrice()
                }
            ZStack {
                RoundedRectangle(cornerRadius: 10.0)
                    .fill(Color.gray)
                    .shadow(radius: 7)
                Text("删除")
                    .foregroundColor(Color.white)
            }
            .frame(width: 80, height: 35, alignment: .center)
            .onTapGesture {
                deleteItems()
            }
            ZStack {
                RoundedRectangle(cornerRadius: 10.0)
                    .fill(Color.red)
                    .shadow(radius: 7)
                Text("购买")
                    .foregroundColor(Color.white)
            }
            .alert(isPresented: $showMsg) {
                Alert(title: Text("成功"), message: Text("购买成功！"))
            }
            .onTapGesture {
                payItems()
                showMsg = true
            }
            .frame(width: 80, height: 35, alignment: .center)
        }
        .padding()
        .padding(.trailing, 20)
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
    
    func deleteItems() {
        for card in cards {
            if card.toggleIsOn {
                self.viewModel.deleteOrder(orderID: card.order.id)
            }
        }
        refreshCards()
    }
    
    func payItems() {
        for card in cards {
            if card.toggleIsOn {
                self.viewModel.pay(orderID: card.order.id)
            }
        }
        refreshCards()
    }
    
    func refreshCards() {
        _cards.wrappedValue.removeAll()
        let orders = viewModel.getItems()
        var i: Int = 0
        for order in orders {
            let item = preserveCard(id: i, order: order, flag: $toggleIsOn[i])
            cards.append(item)
            i = i + 1
            if i == 10 {
                break
            }
        }
        getTotalPrice()
    }
    
    func getTotalPrice() {
        var tmp: Double = 0
        for card in cards {
            if card.toggleIsOn {
                tmp += Double(card.order.number) * card.order.book.price
            }
        }
        self.totalPrice = tmp
    }
}

struct preserveCard: View, Identifiable {
    public var id: Int
    @Binding var toggleIsOn: Bool
    public var order: Order
    public var show: Bool = true
    
    init(id: Int, order: Order, flag: Binding<Bool>) {
        self.id = id
        self.order = order
        _toggleIsOn = flag
    }
    
    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .frame(width: 25, height: 25)
                    .foregroundColor(toggleIsOn ? Color.red : Color.white)
                    .cornerRadius(12.5)
                    .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                Image(systemName: toggleIsOn ? "checkmark" : "")
                    .foregroundColor(Color.white)
            }
            .onTapGesture {
                toggleIsOn.toggle()
            }
            Image(order.book.name)
                .resizable()
                .frame(maxWidth: 100, maxHeight: 100)
                .aspectRatio(contentMode: .fit)
            VStack {
                Text("书名：\(self.order.book.name)")
                    .padding(1)
                    .frame(minWidth:180, alignment: .leading)
                Text("作者：\(self.order.book.author)")
                    .padding(1)
                    .frame(minWidth:180, alignment: .leading)
                Text("数量：\(self.order.number)")
                    .padding(1)
                    .frame(minWidth:180, alignment: .leading)
                Text("¥" + String(format:"%.2f", self.order.book.price))
                    .font(.title2)
                    .foregroundColor(Color.red)
                    .padding(1)
                    .frame(minWidth:180, alignment: .trailing)
            }
            .frame(minHeight: 140, alignment: .center)
        }
        .padding()
        .frame(minWidth: 350, minHeight: 150, alignment: .leading)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 10)
    }
}


struct ShoppingCarView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingCarView(viewModel: ShoppingCarViewModel(userID: 1))
    }
}
