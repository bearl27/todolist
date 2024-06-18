//
//  ItemModel.swift
//  todolist
//
//  Created by kai on 2024/04/01.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

/// ViewModel for single to do list item view(each row in items list)
class BigGroupModel: ObservableObject{
    @Published var showingChildView = false
    init(){}
    
    func toggleIsDone(bigGroup: BigGroup) {
        var bigGroupCopy = bigGroup
        bigGroupCopy.setDone(!bigGroup.isDone)
        
        guard let uid = Auth.auth().currentUser?.uid else{
            return
        }
        
        let db = Firestore.firestore()
        db.collection("users")
            .document(uid)
            .collection("bigGoal")
            .document(bigGroupCopy.id)
            .setData(bigGroupCopy.asDictionary())
    }
}
