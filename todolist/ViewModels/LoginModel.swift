//
//  LoginModel.swift
//  todolist
//
//  Created by kai on 2024/03/23.
//

import Foundation
import FirebaseAuth

class LoginModel: ObservableObject{
    
    @Published var email = ""
    @Published var password = ""
    @Published var errormessage = ""
    
    init(){
        
    }
    
    func login(){
        guard validate() else{
            return
        }
        
        //Try log in
        Auth.auth().signIn(withEmail: email, password: password)
        
        
    }
    
   private func validate() -> Bool{
       errormessage = ""
       guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
             !password.trimmingCharacters(in: .whitespaces).isEmpty else{
           //print("notext")
           errormessage = "正しく入力してください"
           return false
       }
       
       // email@foo.com
       guard email.contains("@") && email.contains(".") else{
           errormessage = "メールアドレスを正しく入力してください"
           return false
       }
       
       print("Called")//debug
       return true
    }
}
