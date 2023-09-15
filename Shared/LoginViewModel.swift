//
//  LoginViewModel.swift
//  mall
//
//  Created by eumendies on 2023/5/18.
//

import Foundation
import SQLite

class LoginViewModel: ObservableObject{
    @Published public var user: User = User()
    
    func login(userName: String, password: String) -> Bool {
        if userName == "" || password == "" {
            return false
        }
        do {
            let path = Bundle.main.url(forResource: "test", withExtension: ".db")
            let db = try Connection(path!.path)
            let users = Table("users")
            let id = Expression<Int64>("id")
            let c_userName = Expression<String>("userName")
            let c_password = Expression<String>("password")
            let query = users.filter(c_userName == userName)
            for user in try db.prepare(query) {
                if user[c_password] == password {
                    self.user = User(id: user[id], userName: user[c_userName], password: user[c_password])
                    return true
                }
            }
        } catch {
            print("\(error)")
        }
        return false
    }
    
    
    func signUp(userName: String, password: String) -> Bool{
        if userName == "" || password == "" {
            return false
        }
        do {
            let path = Bundle.main.url(forResource: "test", withExtension: ".db")
            let db = try Connection(path!.path)
            let users = Table("users")
            let c_userName = Expression<String>("userName")
            let c_password = Expression<String>("password")
            do {
                try db.run(users.insert(c_userName <- userName, c_password <- password))
            }
            catch {
                return false
            }
        } catch {
            print("\(error)")
        }
        return false
    }
}
