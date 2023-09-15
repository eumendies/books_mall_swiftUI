//
//  MeView.swift
//  mall (iOS)
//
//  Created by eumendies on 2023/5/16.
//

import SwiftUI

struct MeView: View {
    @State private var user: User
    
    init(user: User) {
        self.user = user
    }
    
    var body: some View {
        ZStack {
            Color(red: 0.9, green: 0.9, blue: 0.9, opacity: 0.8)
                .ignoresSafeArea()
            
            VStack {
                Image(systemName: "person")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .cornerRadius(50)
                Text("用户名：\(self.user.userName)")
                    .padding(10)
                    .font(.title2)
                menuItems()
            }
            .padding(.top, 30)
            .frame(minWidth: 350, alignment: .top)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: 10)
        }
    }
}

struct menuItems: View {
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "gearshape")
                    .resizable()
                    .frame(width:30, height: 30)
                Text("设置")
                    .font(.title2)
                    .padding()
                    .padding(.trailing, 180)
                Image(systemName: "chevron.right")
                    .resizable()
                    .frame(width:12, height: 20)
                    .foregroundColor(Color.gray)
            }
            .padding(.leading, 10)
            .frame(minWidth: 350, alignment: .leading)
            NavigationLink(destination: aboutView()) {
                HStack {
                    Image(systemName: "list.bullet")
                        .resizable()
                        .frame(width:30, height: 25)
                        .foregroundColor(Color.blue)
                    Text("关于")
                        .font(.title2)
                        .padding()
                        .padding(.trailing, 180)
                    Image(systemName: "chevron.right")
                        .resizable()
                        .frame(width:12, height: 20)
                        .foregroundColor(Color.gray)
                }
                .padding(.leading, 10)
                .frame(minWidth: 350, alignment: .leading)
            }
            .foregroundColor(Color.black)
            HStack {
                Image(systemName: "multiply")
                    .resizable()
                    .frame(width:30, height: 30)
                    .foregroundColor(Color.red)
                Text("退出登录")
                    .font(.title2)
                    .padding()
                    .padding(.trailing, 135)
                Image(systemName: "chevron.right")
                    .resizable()
                    .frame(width:12, height: 20)
                    .foregroundColor(Color.gray)
            }
            .padding(.leading, 10)
            .frame(minWidth: 350, alignment: .leading)
        }
        .padding(.bottom, 30)
    }
}

struct aboutView: View {
    var body: some View {
        ZStack {
            Color(red: 0.9, green: 0.9, blue: 0.9, opacity: 0.8)
                .ignoresSafeArea()
            
            VStack (spacing: 8) {
                Text("APP名称：图书商城")
                Text("版本：1.0")
                Text("制作时间：2023-5-25")
                Text("作者：刘志锋")
                Text("学号：2021302111042")
                Text("电子邮箱：1431538355@qq.com")
                Text("手机号：15277429330")
                Text("⚠️注意：目前应用仍有bug，如果添加商品进购物车或者购买商品后在购物车和历史订单中没有看到相应的项，请切换一下tab")
            }
            .padding()
            .frame(width: 350, height: 400)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 10)
        }
    }
}

struct MeView_Previews: PreviewProvider {
    static var previews: some View {
        MeView(user: User())
    }
}
