//
//  RegModel.swift
//  todolist
//
//  Created by kai on 2024/03/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class RegModel: ObservableObject{
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    @Published var errormesage = ""
    @Published var emailError = ""
    @Published var passError = ""
    
    
    init(){}
    
    func register(){
        guard validate() else{
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password){
            [weak self]result,error in
            guard let userId = result?.user.uid else{
                return
            }
            
            self?.insertUserRecord(id: userId)
        }
    }
    
    private func insertUserRecord(id: String){
        let newUser = User(id: id,
                           name: name,
                           email: email,
                           joined: Date().timeIntervalSince1970,
                           doneItemNum: 0,
                           doneMidNum: 0,
                           doneDreamNum: 0)
        
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(id)
            .setData(newUser.asDictionary())
    }
    
    private func validate() -> Bool{
        errormesage = ""
        emailError = ""
        passError = ""
        
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty,
              !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else{
            errormesage = "全て入力してください"
            return false
        }
        
        // email@foo.com
        guard email.contains("@") && email.contains("."),
              password.count >= 8
        else{
            if !(email.contains("@") && email.contains(".")){
                emailError = "メールアドレスを正しく入力してください"
            }
            if password.count < 8{
                passError = "パスワードを8文字以上にしてください"
            }
            return false
        }
        
        return true
    }
}
