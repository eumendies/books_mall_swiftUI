//
//  HistoryView.swift
//  mall (iOS)
//
//  Created by eumendies on 2023/5/16.
//

import SwiftUI

struct HistoryView: View {
    private var viewModel: HistoryViewModel
    
    init(viewModel: HistoryViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack{
            Color(red: 0.9, green: 0.9, blue: 0.9, opacity: 0.8)
                .ignoresSafeArea()
            VStack {
                ScrollView {
                    ForEach (viewModel.getItems()) {order in
                        OrderCard(order: order)
                            .padding()
                    }
                }
            }
        }
        
    }
}

struct OrderCard: View {
    private var order: Order
    
    init(order: Order) {
        self.order = order
    }
    
    var body: some View {
        HStack {
            Image(order.book.name)
                .resizable()
                .frame(maxWidth: 100, maxHeight: 100)
                .aspectRatio(contentMode: .fit)
            VStack {
                Text("订单编号：\(order.id)")
                    .padding(1)
                    .frame(minWidth:180, alignment: .leading)
                Text("书名：\(order.book.name)")
                    .padding(1)
                    .frame(minWidth:180, alignment: .leading)
                Text("数量：\(order.number)")
                    .padding(1)
                    .frame(minWidth:180, alignment: .leading)
                Text("总价：¥" + String(format:"%.2f", order.book.price * Double(order.number)))
                    .padding(1)
                    .frame(minWidth:180, alignment: .leading)
                Text("支付时间：\(order.time)")
                    .padding(1)
                    .frame(minWidth:180, alignment: .leading)
            }
            .frame(minHeight: 140, alignment: .center)
        }
        .padding()
        .frame(minWidth: 300, minHeight: 150, alignment: .leading)
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 10)
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(viewModel: HistoryViewModel(userID: 1))
    }
}
