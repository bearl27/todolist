//
//  NewItemModel.swift
//  todolist
//
//  Created by kai on 2024/04/01.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore


class NewBigGroupModel: ObservableObject{
    @Published var title = ""
    @Published var dueDate = Date()
    @Published var showAlert = false
    
    
    
    init(){}
    
    func save(){
        guard canSave else{
            return
        }
        //Get Current User ID
        guard let uId = Auth.auth().currentUser?.uid else{
            return
        }
        
        //Create model
        let newId = UUID().uuidString
        let newBigGroup = BigGroup(
            id: newId,
            title: title,
            dueDate: dueDate.timeIntervalSince1970,
            createDate: Date().timeIntervalSince1970,
            isDone: false
        )
        
        //Save model
        let db = Firestore.firestore()
        db.collection("users")
                .document(uId)
                .collection("bigGoal")
                .document(newId)
                .setData(newBigGroup.asDictionary())
    }
    
    var canSave: Bool{
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else{
            return false
        }
        
        //86400は1日の秒数
        guard dueDate >= Date().addingTimeInterval(-86400) else {
            return false
        }
        
        return true
    }
}
