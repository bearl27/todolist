//
//  ContentView.swift
//  todolist
//
//  Created by kai on 2024/03/23.
//

import SwiftUI

struct Main: View {
    @StateObject var viewModel = MainModel()
    
    var body: some View {
        if viewModel.isSinedIn, !viewModel.currentUserId.isEmpty{
            // signed in
            accountView
        }else{
            LoginView()
        }
    }
    
    @ViewBuilder
    var accountView: some View{
        TabView{
            DreamView(userId: viewModel.currentUserId)
                .tabItem{
                    Label("Dream", systemImage: "star")
                }
            
            MidView(userId: viewModel.currentUserId)
                .tabItem{
                    Label("Mid", systemImage: "star")
                }
            
            ToDoListView(userId: viewModel.currentUserId)
                .tabItem{
                    Label("Home", systemImage: "house")
                }
            
            ProfileView()
                .tabItem{
                    Label("Profile", systemImage: "person.circle")
                }
        }
    }
}

#Preview {
    Main()
}
