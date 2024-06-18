//
//  ListModel.swift
//  todolist
//
//  Created by kai on 2024/03/23.
//

import Foundation
import FirebaseFirestore

/// ViewModel for list of items view
/// Primary tab
class ListModel: ObservableObject{
    @Published var showingNewItemView = false
    
    private let userId: String
    
    init(userId: String){
        self.userId = userId
    }
    
    
    /// Delete to do list item
    ///  - Parameter id: Item id to delete
    func delete(id: String){
        let db = Firestore.firestore()

        db.collection("users")
            .document(userId)
            .collection("todos")
            .document(id)
            .delete()
    }
}
