//
//  ProfileView.swift
//  todolist
//
//  Created by kai on 2024/04/01.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if let user = viewModel.user {
                    profile(user: user)
                } else {
                    Text("Loading Profile...")
                }
            }
            .navigationTitle("Profile")
        }
        .onAppear {
            viewModel.fetchUser()
        }
    }
    
    
    @ViewBuilder
    func profile(user: User) -> some View {
            //Avatar
            Image(systemName: "person.circle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.blue)
                .frame(width: 125,height: 125)
                .padding()
            
            //Info
            VStack(alignment: .leading) {
                HStack{
                    Text("Name: ")
                    Text(user.name)
                }.padding()
                
                HStack {
                    Text("Email:")
                    Text(user.email)
                }
                .padding()
                
                HStack {
                    Text("Member Since:")
                    Text("\(Date(timeIntervalSince1970: user.joined).formatted(date: .abbreviated, time: .shortened))")
                }
                .padding()
            }
            
            // Sign out
            Section {
                Button("Log Out") {
                    viewModel.logOut()
                }
                .tint(.red)
                .padding()
                
                Spacer()
            }
        }
    }
    
