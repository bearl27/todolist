//
//  todolistApp.swift
//  todolist
//
//  Created by kai on 2024/03/23.
//

import FirebaseCore
import SwiftUI

@main
struct todolistApp: App {
    init(){
        FirebaseApp.configure() 
    }
    var body: some Scene {
        WindowGroup {
            Main()
        }
    }
}
