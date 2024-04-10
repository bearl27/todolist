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
class MidGroupModel: ObservableObject{
    init(){}
    
    func toggleIsDone(midGroup: MidGroup) {
        var midGroupCopy = midGroup
        midGroupCopy.setDone(!midGroup.isDone)
        
        guard let uid = Auth.auth().currentUser?.uid else{
            return
        }
        
        let db = Firestore.firestore()
        db.collection("users")
            .document(uid)
            .collection("bigGoal")
            .document(midGroupCopy.parent.id)
            .collection("midGoal")
            .document(midGroupCopy.id)
            .setData(midGroupCopy.asDictionary())
    }
}
