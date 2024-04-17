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
class ItemModel: ObservableObject{
    init(){}
    
    func toggleIsDone(item: Item) {
        var itemCopy = item
        itemCopy.setDone(!item.isDone)
        
        guard let uid = Auth.auth().currentUser?.uid else{
            return
        }
        
        let db = Firestore.firestore()
        db.collection("users")
            .document(uid)
//            .collection("bigGoal")
//            .document(itemCopy.parent.parent.id)
//            .collection("midGoal")
//            .document(itemCopy.parent.id)
            .collection("todos")
            .document(itemCopy.id)
            .setData(itemCopy.asDictionary())
    }
}
