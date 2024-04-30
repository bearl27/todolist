//
//  ItemsView.swift
//  todolist
//
//  Created by kai on 2024/04/01.
//

import SwiftUI

struct MidGroupsView: View {
    @StateObject var viewModel = MidGroupModel()
    @StateObject var main = MainModel()
    let midGroup: MidGroup
    
    var body: some View {
        HStack{
            Button{
                viewModel.toggleIsDone(midGroup: midGroup)
            } label:{
                Image(systemName: midGroup.isDone ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(.blue)
            }.padding(.horizontal,20)
            
            VStack(alignment: .leading){
                
                Text(midGroup.title)
                    .font(.body)
                    .bold()
                Text("\(Date(timeIntervalSince1970: midGroup.dueDate).formatted(date: .abbreviated, time: .shortened))")
                    .font(.footnote)
                    .foregroundColor(.gray)
                
            }
            Spacer()
            NavigationLink {
                ToDoListView(userId: main.currentUserId)
            } label: {
                
            }
            .buttonStyle(PlainButtonStyle())
            .padding(.horizontal, 20)
        }
    }
}

#Preview {
    MidGroupsView(midGroup: .init(id: "123",
                          title: "mid",
                         dueDate: Date().timeIntervalSince1970,
                         createDate: Date().timeIntervalSince1970,
                                  parent:BigGroup(id: "001", title: "dream", dueDate: Date().timeIntervalSince1970, createDate: Date().timeIntervalSince1970, isDone: false),
                         isDone: false))
}
