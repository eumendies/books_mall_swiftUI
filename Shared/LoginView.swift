//
//  LoginView.swift
//  mall
//
//  Created by eumendies on 2023/5/18.
//

import SwiftUI

struct LoginView: View {
    private var viewModel: LoginViewModel
    @State private var loginSelected: Bool = true
    @State private var userName: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var showAlert: Bool = false
    @State private var alert_msg: String = ""
    @State private var alert_title: String = ""
    @State private var show: Binding<Bool>
    
    init(show: Binding<Bool>, viewModel: LoginViewModel) {
        self.show = show
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            // background
            Color(red: 0.9, green: 0.9, blue: 0.9, opacity: 0.8)
                .ignoresSafeArea()
            
            // content
            VStack (spacing: 20){
                Spacer()
                self.chooseButtons
                self.loginItems
                self.confirmButton
                Spacer()
            }
            .frame(width: 350, height: 400, alignment: .center)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: 10)
        }
    }
    
    var chooseButtons: some View {
        HStack {
            Spacer()
            Button("登录") {
                loginSelected = true
                clear()
            }
            .frame(width: 80, height: 40)
            .foregroundColor(loginSelected ? Color.white : Color.blue)
            .background(loginSelected ? Color.blue : Color.white)
            .cornerRadius(5)
            Button("注册") {
                loginSelected = false
                clear()
            }
            .frame(width: 80, height: 40)
            .foregroundColor(!loginSelected ? Color.white : Color.blue)
            .background(!loginSelected ? Color.blue : Color.white)
            .cornerRadius(5)
            Spacer()
        }
    }
    
    var loginItems: some View {
        VStack (spacing: 20) {
            HStack {
                Spacer(minLength: 40)
                Text("用户名：").padding(1)
                    .frame(width: 75)
                TextField("", text: $userName)
                    .cornerRadius(5)
                    .border(Color.blue)
                    .disableAutocorrection(true)
                    .autocapitalization(UITextAutocapitalizationType.none)
                Spacer(minLength: 40)
            }
            HStack{
                Spacer(minLength: 40)
                Text("密码：").padding(1)
                    .frame(width: 75)
                SecureField("", text: $password)
                    .border(Color.blue)
                Spacer(minLength: 40)
            }
            HStack{
                Spacer(minLength: 40)
                Text("确认密码：").padding(1)
                    .frame(width: 90)
                SecureField("", text: $confirmPassword)
                    .border(Color.blue)
                Spacer(minLength: 40)
            }
            .opacity(loginSelected ? 0 : 1)
        }
    }
    
    var confirmButton: some View {
        Button("确认") {
            self.loginOrSignUp()
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alert_title), message: Text(alert_msg))
        }
        .foregroundColor(Color.white)
        .frame(width: 80, height: 40)
        .background(Color.blue)
        .cornerRadius(5)
    }
    
    func clear() {
        self.userName = ""
        self.password = ""
        self.confirmPassword = ""
    }
    
    func loginOrSignUp() {
        if loginSelected {
            if !viewModel.login(userName: self.userName, password: self.password) {
                self.alert_title = "错误"
                self.alert_msg = "用户名或密码错误！"
                self.showAlert = true
            }
            else {
                show.wrappedValue.toggle()
            }
        }
        else {
            if self.password != self.confirmPassword {
                self.alert_title = "错误"
                self.alert_msg = "两次输入的密码不相同！"
                self.showAlert = true
            }
            else {
                if !viewModel.signUp(userName: self.userName, password: self.password) {
                    self.alert_title = "错误"
                    self.alert_msg = "用户名已存在！"
                    self.showAlert = true
                }
                else {
                    self.alert_title = "成功"
                    self.alert_msg = "注册成功！"
                    self.showAlert = true
                    clear()
                }
            }
        }
    }
}


//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView(show: true)
//    }
//}
