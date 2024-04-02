//
//  MainModel.swift
//  todolist
//
//  Created by kai on 2024/03/23.
//

import Foundation
import FirebaseAuth

class MainModel: ObservableObject{
    @Published var currentUserId: String = ""
    private var handler: AuthStateDidChangeListenerHandle?
    
    init(){
        self.handler = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            self?.currentUserId = user?.uid ?? ""
        }
    }
    
    public var isSinedIn: Bool{
        return Auth.auth().currentUser != nil
    }
    
}
