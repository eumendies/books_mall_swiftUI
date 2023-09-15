//
//  MainView.swift
//  mall (iOS)
//
//  Created by eumendies on 2023/5/15.
//

import SwiftUI

struct MainView: View {
    @State var title: String = "商城"
    @State var showLogin: Bool = true
    @State var user: User = User()
    @ObservedObject private var loginViewModel: LoginViewModel = LoginViewModel()
    
    init() {
        UITabBar.appearance().isTranslucent = false;
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                self.tabBar
                if showLogin {
                    LoginView(show: $showLogin, viewModel: loginViewModel)
                        .background(Color(red: 0.9, green: 0.9, blue: 0.9, opacity: 1))
                }
            }
            .onChange(of: showLogin) { id in
                self.user = loginViewModel.user
            }
        }
    }
    
    var tabBar: some View {
        TabView {
            BooksView(viewModel: BooksViewModel(), user: self.user)
                .tabItem{
                    Image(systemName: "book")
                    Text("书籍")
                }
                .onAppear(perform: {title = "商城"})
            ShoppingCarView(viewModel: ShoppingCarViewModel(userID: self.user.id))
                .tabItem{
                    Image(systemName: "cart")
                    Text("购物车")
                }
                .onAppear(perform: {title = "购物车"})
            HistoryView(viewModel: HistoryViewModel(userID: self.user.id))
                .tabItem{
                    Image(systemName: "doc.text")
                    Text("历史订单")
                }
                .onAppear(perform: {title = "历史订单"})
            MeView(user: self.user)
                .tabItem{
                    Image(systemName: "person")
                    Text("我")
                }
                .onAppear(perform: {title = "我"})
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
